# ---------------------------------------------------------------------------------------------------------------------
# AWS KMS Encryption Key
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_kms_key" "encryption_key" {
  description         = "${var.name_preffix} ECS Encryption Key"
  is_enabled          = true
  enable_key_rotation = true
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Security Groups - ECS Tasks, allow traffic only from Load Balancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "ecs_tasks_sg" {
  name        = "${var.name_preffix}-ecs-tasks-sg"
  description = "Allow inbound access from the LB only"
  vpc_id      = var.vpc_id
  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = [aws_security_group.lb_sg.id]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name_preffix}-ecs-tasks-sg"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Service
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
  name            = "${var.name_preffix}-service"
  depends_on      = [aws_lb_listener.listener]
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.td.arn
  launch_type     = "FARGATE"
  desired_count   = 1
  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks_sg.id]
    subnets          = var.private_subnets_ids
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Auto Scale Role
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_autoscale_role" {
  name               = "${var.name_preffix}-ecs-autoscale-role"
  assume_role_policy = file("${path.module}/files/iam/ecs_autoscale_iam_role.json")
}

resource "aws_iam_role_policy" "ecs_autoscale_role_policy" {
  name = "${var.name_preffix}-ecs-autoscale-role-policy"
  role = aws_iam_role.ecs_autoscale_role.id
  policy = file(
    "${path.module}/files/iam/ecs_autoscale_iam_role_policy.json",
  )
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Auto Scaling - CloudWatch Alarm CPU High
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_high" {
  alarm_name          = "${var.name_preffix}-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "85"
  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_up_policy.arn]
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Auto Scaling - CloudWatch Alarm CPU Low
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_cloudwatch_metric_alarm" "cpu_low" {
  alarm_name          = "${var.name_preffix}-cpu-low"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "3"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"
  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.service.name
  }
  alarm_actions = [aws_appautoscaling_policy.scale_down_policy.arn]
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Auto Scaling - Scaling Up Policy
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "scale_up_policy" {
  name               = "${var.name_preffix}-scale-up-policy"
  depends_on         = [aws_appautoscaling_target.scale_target]
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Auto Scaling - Scaling Down Policy
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_policy" "scale_down_policy" {
  name               = "${var.name_preffix}-scale-down-policy"
  depends_on         = [aws_appautoscaling_target.scale_target]
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Auto Scaling - Scaling Target
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_appautoscaling_target" "scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_autoscale_role.arn
  min_capacity       = 1
  max_capacity       = 5
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Security Groups - Control Access to ALB
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "lb_sg" {
  name        = "${var.name_preffix}-lb-sg"
  description = "Control access to LB"
  vpc_id      = var.vpc_id
  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.name_preffix}-lb-sg"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Load Balancer
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_lb" "lb" {
  name                             = "${var.name_preffix}-lb"
  internal                         = false
  load_balancer_type               = "application"
  subnets                          = var.public_subnets_ids
  security_groups                  = [aws_security_group.lb_sg.id]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = true
  tags = {
    Name = "${var.name_preffix}-lb"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS LB Target Group
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_lb_target_group" "lb_tg" {
  depends_on  = [aws_lb.lb]
  name        = "${var.name_preffix}-lb-tg"
  target_type = "ip"
  protocol    = "HTTP"
  port        = var.container_port
  vpc_id      = var.vpc_id
  health_check {
    path = var.health_check_path
    port = var.container_port
  }
  tags = {
    Name = "${var.name_preffix}-lb-tg"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS LB Listener
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_lb_listener" "listener" {
  depends_on        = [aws_lb_target_group.lb_tg]
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    type             = "forward"
  }
}
