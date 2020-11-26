#------------------------------------------------------------------------------
# ECS CLUSTER
#------------------------------------------------------------------------------
output "aws_ecs_cluster_cluster_name" {
  description = "The name of the cluster"
  value       = module.ecs-cluster.aws_ecs_cluster_cluster_name
}

output "aws_ecs_cluster_cluster_id" {
  description = "The Amazon ID that identifies the cluster"
  value       = module.ecs-cluster.aws_ecs_cluster_cluster_id
}

output "aws_ecs_cluster_cluster_arn" {
  description = "The Amazon Resource Name (ARN) that identifies the cluster"
  value       = module.ecs-cluster.aws_ecs_cluster_cluster_arn
}

#------------------------------------------------------------------------------
# AWS ECS Task Execution Role
#------------------------------------------------------------------------------
output "aws_iam_role_ecs_task_execution_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_arn
}
output "aws_iam_role_ecs_task_execution_role_create_date" {
  description = "The creation date of the IAM role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_create_date
}
output "aws_iam_role_ecs_task_execution_role_description" {
  description = "The description of the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_description
}
output "aws_iam_role_ecs_task_execution_role_id" {
  description = "The ID of the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_id
}
output "aws_iam_role_ecs_task_execution_role_name" {
  description = "The name of the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_name
}
output "aws_iam_role_ecs_task_execution_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = module.td.aws_iam_role_ecs_task_execution_role_unique_id
}

#------------------------------------------------------------------------------
# ECS Task Definition
#------------------------------------------------------------------------------
output "aws_ecs_task_definition_td_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = module.td.aws_ecs_task_definition_td_arn
}

output "aws_ecs_task_definition_td_family" {
  description = "The family of the Task Definition."
  value       = module.td.aws_ecs_task_definition_td_family
}

output "aws_ecs_task_definition_td_revision" {
  description = "The revision of the task in a particular family."
  value       = module.td.aws_ecs_task_definition_td_revision
}
output "container_name" {
  description = "Name of the container"
  value       = var.container_name
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "aws_lb_lb_id" {
  description = "The ARN of the load balancer (matches arn)."
  value       = module.ecs-fargate-service.aws_lb_lb_id
}

output "aws_lb_lb_arn" {
  description = "The ARN of the load balancer (matches id)."
  value       = module.ecs-fargate-service.aws_lb_lb_arn
}

output "aws_lb_lb_arn_suffix" {
  description = "The ARN suffix for use with CloudWatch Metrics."
  value       = module.ecs-fargate-service.aws_lb_lb_arn_suffix
}

output "aws_lb_lb_dns_name" {
  description = "The DNS name of the load balancer."
  value       = module.ecs-fargate-service.aws_lb_lb_dns_name
}

output "aws_lb_lb_zone_id" {
  description = "The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record)."
  value       = module.ecs-fargate-service.aws_lb_lb_zone_id
}

#------------------------------------------------------------------------------
# ACCESS CONTROL TO APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
output "aws_security_group_lb_access_sg_id" {
  description = "The ID of the security group"
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_id
}

output "aws_security_group_lb_access_sg_arn" {
  description = "The ARN of the security group"
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_arn
}

output "aws_security_group_lb_access_sg_vpc_id" {
  description = "The VPC ID."
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_vpc_id
}

output "aws_security_group_lb_access_sg_owner_id" {
  description = "The owner ID."
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_owner_id
}

output "aws_security_group_lb_access_sg_name" {
  description = "The name of the security group"
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_name
}

output "aws_security_group_lb_access_sg_description" {
  description = "The description of the security group"
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_description
}

output "aws_security_group_lb_access_sg_ingress" {
  description = "The ingress rules."
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_ingress
}

output "aws_security_group_lb_access_sg_egress" {
  description = "The egress rules."
  value       = module.ecs-fargate-service.aws_security_group_lb_access_sg_egress
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
output "lb_http_tgs_ids" {
  description = "List of HTTP Target Groups IDs"
  value       = module.ecs-fargate-service.lb_http_tgs_ids
}

output "lb_http_tgs_arns" {
  description = "List of HTTP Target Groups ARNs"
  value       = module.ecs-fargate-service.lb_http_tgs_arns
}

output "lb_http_tgs_names" {
  description = "List of HTTP Target Groups Names"
  value       = module.ecs-fargate-service.lb_http_tgs_names
}

output "lb_https_tgs_ids" {
  description = "List of HTTPS Target Groups IDs"
  value       = module.ecs-fargate-service.lb_https_tgs_ids
}

output "lb_https_tgs_arns" {
  description = "List of HTTPS Target Groups ARNs"
  value       = module.ecs-fargate-service.lb_https_tgs_arns
}

output "lb_https_tgs_names" {
  description = "List of HTTPS Target Groups Names"
  value       = module.ecs-fargate-service.lb_https_tgs_names
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Listeners
#------------------------------------------------------------------------------
output "lb_http_listeners_ids" {
  description = "List of HTTP Listeners IDs"
  value       = module.ecs-fargate-service.lb_http_listeners_ids
}

output "lb_http_listeners_arns" {
  description = "List of HTTP Listeners ARNs"
  value       = module.ecs-fargate-service.lb_http_listeners_arns
}

output "lb_https_listeners_ids" {
  description = "List of HTTPS Listeners IDs"
  value       = module.ecs-fargate-service.lb_https_listeners_ids
}

output "lb_https_listeners_arns" {
  description = "List of HTTPS Listeners ARNs"
  value       = module.ecs-fargate-service.lb_https_listeners_arns
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
output "aws_ecs_service_service_id" {
  description = "The Amazon Resource Name (ARN) that identifies the service."
  value       = module.ecs-fargate-service.aws_ecs_service_service_id
}

output "aws_ecs_service_service_name" {
  description = "The name of the service."
  value       = module.ecs-fargate-service.aws_ecs_service_service_name
}

output "aws_ecs_service_service_cluster" {
  description = "The Amazon Resource Name (ARN) of cluster which the service runs on."
  value       = module.ecs-fargate-service.aws_ecs_service_service_cluster
}

output "aws_ecs_service_service_desired_count" {
  description = "The number of instances of the task definition"
  value       = module.ecs-fargate-service.aws_ecs_service_service_desired_count
}

#------------------------------------------------------------------------------
# AWS SECURITY GROUPS
#------------------------------------------------------------------------------
output "ecs_tasks_sg_id" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The ID of the security group"
  value       = module.ecs-fargate-service.ecs_tasks_sg_id
}

output "ecs_tasks_sg_arn" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The ARN of the security group"
  value       = module.ecs-fargate-service.ecs_tasks_sg_arn
}

output "ecs_tasks_sg_name" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The name of the security group"
  value       = module.ecs-fargate-service.ecs_tasks_sg_name
}

output "ecs_tasks_sg_description" {
  description = "$${var.name_prefix} ECS Tasks Security Group - The description of the security group"
  value       = module.ecs-fargate-service.ecs_tasks_sg_description
}
