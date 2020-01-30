# ---------------------------------------------------------------------------------------------------------------------
# PROVIDER
# ---------------------------------------------------------------------------------------------------------------------
provider "aws" {
  profile = var.profile
  region  = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Cluster
# ---------------------------------------------------------------------------------------------------------------------
module ecs-cluster {
  source  = "cn-terraform/ecs-cluster/aws"
  version = "1.0.2"
  name    = var.name_preffix
  profile = var.profile
  region  = var.region
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Task Definition
# ---------------------------------------------------------------------------------------------------------------------
module "ecs-fargate-task-definition" {
  source       = "cn-terraform/ecs-fargate-task-definition/aws"
  version      = "1.0.8"
  name_preffix = var.name_preffix
  profile      = var.profile
  region       = var.region
  command                      = var.command
  container_name               = var.container_name
  container_image              = var.container_image
  container_port               = var.container_port
  container_cpu                = var.container_cpu
  container_depends_on         = var.container_depends_on
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  dns_servers                  = var.dns_servers
  docker_labels                = var.docker_labels
  entrypoint                   = var.entrypoint
  environment                  = var.environment
  essential                    = var.essential
  firelens_configuration       = var.firelens_configuration
  healthcheck                  = var.healthcheck
  links                        = var.links
  log_configuration            = var.log_configuration
  mount_points                 = var.mount_points
  readonly_root_filesystem     = var.readonly_root_filesystem
  repository_credentials       = var.repository_credentials
  secrets                      = var.secrets
  start_timeout                = var.start_timeout
  stop_timeout                 = var.stop_timeout
  system_controls              = var.system_controls
  ulimits                      = var.ulimits
  user                         = var.user
  volumes_from                 = var.volumes_from
  working_directory            = var.working_directory
  placement_constraints        = var.placement_constraints_task_definition
  proxy_configuration          = var.proxy_configuration
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Service
# ---------------------------------------------------------------------------------------------------------------------
module "ecs-fargate-service" {
  source              = "cn-terraform/ecs-fargate-service/aws"
  version             = "1.0.6"
  name_preffix        = var.name_preffix
  profile             = var.profile
  region              = var.region
  vpc_id              = var.vpc_id
  subnets             = var.private_subnets_ids

  ecs_cluster_name      = module.ecs-cluster.aws_ecs_cluster_cluster_name
  ecs_cluster_arn       = module.ecs-cluster.aws_ecs_cluster_cluster_arn
  task_definition_arn   = module.ecs-fargate-task-definition.aws_ecs_task_definition_td_arn
  container_name        = module.ecs-fargate-task-definition.container_name
  container_port        = module.ecs-fargate-task-definition.container_port
  desired_count         = var.desired_count
  platform_version      = var.platform_version
  propagate_tags        = var.propagate_tags
  service_registries    = var.service_registries
  security_groups       = var.security_groups
  assign_public_ip      = var.assign_public_ip
  placement_constraints = var.placement_constraints_ecs_service
  lb_health_check_path  = var.lb_health_check_path
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  ordered_placement_strategy         = var.ordered_placement_strategy
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
}
