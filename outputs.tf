# ---------------------------------------------------------------------------------------------------------------------
# ECS CLUSTER
# ---------------------------------------------------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Task Execution Role
# ---------------------------------------------------------------------------------------------------------------------
output "aws_iam_role_ecs_task_execution_role_arn" {
  description = "The Amazon Resource Name (ARN) specifying the role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_arn
}
output "aws_iam_role_ecs_task_execution_role_create_date" {
  description = "The creation date of the IAM role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_create_date
}
output "aws_iam_role_ecs_task_execution_role_description" {
  description = "The description of the role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_description
}
output "aws_iam_role_ecs_task_execution_role_id" {
  description = "The ID of the role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_id
}
output "aws_iam_role_ecs_task_execution_role_name" {
  description = "The name of the role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_name
}
output "aws_iam_role_ecs_task_execution_role_unique_id" {
  description = "The stable and unique string identifying the role."
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_unique_id
}

# ---------------------------------------------------------------------------------------------------------------------
# ECS Task Definition
# ---------------------------------------------------------------------------------------------------------------------
output "aws_ecs_task_definition_td_arn" {
  description = "Full ARN of the Task Definition (including both family and revision)."
  value       = module.ecs-fargate-task-definition.aws_ecs_task_definition_td_arn
}

output "aws_ecs_task_definition_td_family" {
  description = "The family of the Task Definition."
  value       = module.ecs-fargate-task-definition.aws_ecs_task_definition_td_family
}

output "aws_ecs_task_definition_td_revision" {
  description = "The revision of the task in a particular family."
  value       = module.ecs-fargate-task-definition.aws_ecs_task_definition_td_revision
}
output "container_port" {
  description = "Port on which the container is listening"
  value       = var.container_port
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------
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

# ---------------------------------------------------------------------------------------------------------------------
# AWS LOAD BALANCER
# ---------------------------------------------------------------------------------------------------------------------
output "lb_id" {
  description = "$${var.name_preffix} Load Balancer ID"
  value       = module.ecs-fargate-service.lb_id
}

output "lb_arn" {
  description = "$${var.name_preffix} Load Balancer ARN"
  value       = module.ecs-fargate-service.lb_arn
}

output "lb_arn_suffix" {
  description = "$${var.name_preffix} Load Balancer ARN Suffix"
  value       = module.ecs-fargate-service.lb_arn_suffix
}

output "lb_dns_name" {
  description = "$${var.name_preffix} Load Balancer DNS Name"
  value       = module.ecs-fargate-service.lb_dns_name
}

output "lb_zone_id" {
  description = "$${var.name_preffix} Load Balancer Zone ID"
  value       = module.ecs-fargate-service.lb_zone_id
}