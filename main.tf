#------------------------------------------------------------------------------
# ECS Cluster
#------------------------------------------------------------------------------
module "ecs-cluster" {
  source  = "cn-terraform/ecs-cluster/aws"
  version = "1.0.10"
  # source  = "../terraform-aws-ecs-cluster"

  name = var.name_prefix
  tags = var.tags
}

#------------------------------------------------------------------------------
# ECS Task Definition
#------------------------------------------------------------------------------
module "td" {
  source  = "cn-terraform/ecs-fargate-task-definition/aws"
  version = "1.0.30"
  # source  = "../terraform-aws-ecs-fargate-task-definition"

  name_prefix                  = var.name_prefix
  container_name               = var.container_name
  container_image              = var.container_image
  container_memory             = var.container_memory
  container_memory_reservation = var.container_memory_reservation
  container_definition         = var.container_definition
  port_mappings                = var.port_mappings
  healthcheck                  = var.healthcheck
  container_cpu                = var.container_cpu
  essential                    = var.essential
  entrypoint                   = var.entrypoint
  command                      = var.command
  working_directory            = var.working_directory
  environment                  = var.environment
  extra_hosts                  = var.extra_hosts
  map_environment              = var.map_environment
  environment_files            = var.environment_files
  secrets                      = var.secrets
  readonly_root_filesystem     = var.readonly_root_filesystem
  linux_parameters             = var.linux_parameters
  log_configuration            = var.log_configuration
  firelens_configuration       = var.firelens_configuration
  mount_points                 = var.mount_points
  dns_servers                  = var.dns_servers
  dns_search_domains           = var.dns_search_domains
  ulimits                      = var.ulimits
  repository_credentials       = var.repository_credentials
  volumes_from                 = var.volumes_from
  links                        = var.links
  user                         = var.user
  container_depends_on         = var.container_depends_on
  docker_labels                = var.docker_labels
  start_timeout                = var.start_timeout
  stop_timeout                 = var.stop_timeout
  privileged                   = var.privileged
  system_controls              = var.system_controls
  hostname                     = var.hostname
  disable_networking           = var.disable_networking
  interactive                  = var.interactive
  pseudo_terminal              = var.pseudo_terminal
  docker_security_options      = var.docker_security_options

  permissions_boundary                    = var.permissions_boundary
  placement_constraints                   = var.placement_constraints_task_definition
  proxy_configuration                     = var.proxy_configuration
  ephemeral_storage_size                  = var.ephemeral_storage_size
  ecs_task_execution_role_custom_policies = var.ecs_task_execution_role_custom_policies
  volumes                                 = var.volumes

  tags = var.tags
}

#------------------------------------------------------------------------------
# ECS Service
#------------------------------------------------------------------------------
module "ecs-fargate-service" {
  source  = "cn-terraform/ecs-fargate-service/aws"
  version = "2.0.38"
  # source  = "../terraform-aws-ecs-fargate-service"

  name_prefix = var.name_prefix
  vpc_id      = var.vpc_id

  ecs_cluster_arn                    = module.ecs-cluster.aws_ecs_cluster_cluster_arn
  deployment_maximum_percent         = var.deployment_maximum_percent
  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  desired_count                      = var.desired_count
  enable_ecs_managed_tags            = var.enable_ecs_managed_tags
  enable_execute_command             = var.enable_execute_command
  health_check_grace_period_seconds  = var.health_check_grace_period_seconds
  ordered_placement_strategy         = var.ordered_placement_strategy
  placement_constraints              = var.ecs_service_placement_constraints
  platform_version                   = var.platform_version
  propagate_tags                     = var.propagate_tags
  service_registries                 = var.service_registries
  task_definition_arn                = module.td.aws_ecs_task_definition_td_arn

  # Deployment circuit breaker
  deployment_circuit_breaker_enabled  = var.deployment_circuit_breaker_enabled
  deployment_circuit_breaker_rollback = var.deployment_circuit_breaker_rollback

  # Network configuration block
  public_subnets   = var.public_subnets_ids
  private_subnets  = var.private_subnets_ids
  security_groups  = var.ecs_service_security_groups
  assign_public_ip = var.assign_public_ip

  # ECS Service Load Balancer block
  container_name = var.container_name

  # ECS Autoscaling
  enable_autoscaling = var.enable_autoscaling
  ecs_cluster_name   = module.ecs-cluster.aws_ecs_cluster_cluster_name

  # Application Load Balancer
  custom_lb_arn                       = var.custom_lb_arn
  lb_internal                         = var.lb_internal
  lb_security_groups                  = var.lb_security_groups
  lb_drop_invalid_header_fields       = var.lb_drop_invalid_header_fields
  lb_idle_timeout                     = var.lb_idle_timeout
  lb_enable_deletion_protection       = var.lb_enable_deletion_protection
  lb_enable_cross_zone_load_balancing = var.lb_enable_cross_zone_load_balancing
  lb_enable_http2                     = var.lb_enable_http2
  lb_ip_address_type                  = var.lb_ip_address_type
  waf_web_acl_arn                     = var.lb_waf_web_acl_arn

  # Application Load Balancer Logs
  enable_s3_logs                                 = var.enable_s3_logs
  block_s3_bucket_public_access                  = var.block_s3_bucket_public_access
  enable_s3_bucket_server_side_encryption        = var.enable_s3_bucket_server_side_encryption
  s3_bucket_server_side_encryption_sse_algorithm = var.s3_bucket_server_side_encryption_sse_algorithm
  s3_bucket_server_side_encryption_key           = var.s3_bucket_server_side_encryption_key

  # Access Control to Application Load Balancer
  lb_http_ports                    = var.lb_http_ports
  lb_http_ingress_cidr_blocks      = var.lb_http_ingress_cidr_blocks
  lb_http_ingress_prefix_list_ids  = var.lb_http_ingress_prefix_list_ids
  lb_https_ports                   = var.lb_https_ports
  lb_https_ingress_cidr_blocks     = var.lb_https_ingress_cidr_blocks
  lb_https_ingress_prefix_list_ids = var.lb_https_ingress_prefix_list_ids

  # Target Groups
  lb_deregistration_delay                          = var.lb_deregistration_delay
  lb_slow_start                                    = var.lb_slow_start
  lb_load_balancing_algorithm_type                 = var.lb_load_balancing_algorithm_type
  lb_stickiness                                    = var.lb_stickiness
  lb_target_group_health_check_enabled             = var.lb_target_group_health_check_enabled
  lb_target_group_health_check_interval            = var.lb_target_group_health_check_interval
  lb_target_group_health_check_path                = var.lb_target_group_health_check_path
  lb_target_group_health_check_timeout             = var.lb_target_group_health_check_timeout
  lb_target_group_health_check_healthy_threshold   = var.lb_target_group_health_check_healthy_threshold
  lb_target_group_health_check_unhealthy_threshold = var.lb_target_group_health_check_unhealthy_threshold
  lb_target_group_health_check_matcher             = var.lb_target_group_health_check_matcher

  # Certificates
  default_certificate_arn                         = var.default_certificate_arn
  ssl_policy                                      = var.ssl_policy
  additional_certificates_arn_for_https_listeners = var.additional_certificates_arn_for_https_listeners

  # Optional tags
  tags = var.tags
}
