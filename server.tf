# ---------------------------------------------------------------------------------------------------------------------
# ECS Task Definition
# ---------------------------------------------------------------------------------------------------------------------
module "container_definition" {
    source  = "cloudposse/ecs-container-definition/aws"
    version = "0.7.0"

    container_image              = "${var.container_image}"
    container_name               = "${var.container_name}"
    essential                    = "${var.essential}"
    container_cpu                = "${var.container_cpu}"
    container_memory             = "${var.container_memory}"
    container_memory_reservation = "${var.container_memory_reservation}"
    entrypoint                   = "${var.entrypoint}"
    command                      = "${var.command}"
    log_driver                   = "${local.log_driver}"
    log_options                  = "${local.log_options}"
    port_mappings                = "${local.port_mappings}"
    healthcheck                  = "${var.healthcheck}"
    dns_servers                  = "${var.dns_servers}"
    environment                  = "${var.environment}"
    secrets                      = "${var.secrets}"
    working_directory            = "${var.working_directory}"
    readonly_root_filesystem     = "${var.readonly_root_filesystem}"
    mount_points                 = "${var.mount_points}"
}
# Task Definition
resource "aws_ecs_task_definition" "td" {
    family                   = "${var.name_preffix}-td"
    container_definitions    = "[ ${module.container_definition.json_map} ]"
    requires_compatibilities = [ "FARGATE" ]
    network_mode             = "awsvpc"
    cpu                      = "${var.container_cpu}"
    memory                   = "${var.container_memory}"
    execution_role_arn       = "${aws_iam_role.ecs_task_execution_role.arn}"
    task_role_arn            = "${aws_iam_role.ecs_task_execution_role.arn}"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Service
# ---------------------------------------------------------------------------------------------------------------------
resource "aws_ecs_service" "service" {
    name            = "${var.name_preffix}-service"
    depends_on      = [ "aws_lb_listener.listener" ]
    cluster         = "${aws_ecs_cluster.cluster.id}"
    task_definition = "${aws_ecs_task_definition.td.arn}"
    launch_type     = "FARGATE"
    desired_count   = 1
    network_configuration {
        security_groups  = [ "${aws_security_group.ecs_tasks_sg.id}" ]
        subnets          = [ "${var.private_subnets_ids}" ]
        assign_public_ip = true
    }
    load_balancer {
        target_group_arn = "${aws_lb_target_group.lb_tg.arn}"
        container_name   = "${var.container_name}"
        container_port   = "${var.container_port}"
    }
}
