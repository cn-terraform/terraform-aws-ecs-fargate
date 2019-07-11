# ---------------------------------------------------------------------------------------------------------------------
# ECS Task Definition
# ---------------------------------------------------------------------------------------------------------------------
module "container_definition" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.15.0"

  container_image              = var.container_image
  container_name               = var.container_name
  command                      = var.command
  container_cpu                = var.container_cpu
  container_depends_on         = var.container_depends_on
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  dns_servers                  = var.dns_servers
  entrypoint                   = var.entrypoint
  environment                  = var.environment
  essential                    = var.essential
  healthcheck                  = var.healthcheck
  links                        = var.links
  log_driver                   = local.log_driver
  log_options                  = local.log_options
  mount_points                 = var.mount_points
  port_mappings                = local.port_mappings
  readonly_root_filesystem     = var.readonly_root_filesystem
  repository_credentials       = var.repository_credentials
  secrets                      = var.secrets
  stop_timeout                 = var.stop_timeout
  ulimits                      = var.ulimits
  user                         = var.user
  volumes_from                 = var.volumes_from
  working_directory            = var.working_directory
}

# Task Definition
resource "aws_ecs_task_definition" "td" {
  family                = "${var.name_preffix}-td"
  container_definitions = "[ ${module.container_definition.json_map} ]"
  task_role_arn         = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn    = aws_iam_role.ecs_task_execution_role.arn
  network_mode          = "awsvpc"
  dynamic "placement_constraints" {
    for_each = var.placement_constraints
    content {
      expression = lookup(placement_constraints.value, "expression", null)
      type       = placement_constraints.value.type
    }
  }
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  requires_compatibilities = ["FARGATE"]
  dynamic "proxy_configuration" {
    for_each = var.proxy_configuration
    content {
      container_name = proxy_configuration.value.container_name
      properties     = lookup(proxy_configuration.value, "properties", null)
      type           = lookup(proxy_configuration.value, "type", null)
    }
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

