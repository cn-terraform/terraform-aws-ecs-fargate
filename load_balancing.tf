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
    path = "/"
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

