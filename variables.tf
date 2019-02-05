# ---------------------------------------------------------------------------------------------------------------------
# Misc
# ---------------------------------------------------------------------------------------------------------------------
variable "name_preffix" {
    description = "Name preffix for resources on AWS"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS CREDENTIALS AND REGION
# ---------------------------------------------------------------------------------------------------------------------
variable "profile" {
    description = "AWS API key credentials to use"
}
variable "region" {
    description = "AWS Region the infrastructure is hosted in"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Networking
# ---------------------------------------------------------------------------------------------------------------------
variable "vpc_id" {
    description = "ID of the VPC"
}
variable "availability_zones" {
    type        = "list"
    description = "List of Availability Zones"
}
variable "public_subnets_ids" {
    type        = "list"
    description = "List of Public Subnets IDs"
}
variable "private_subnets_ids" {
    type        = "list"
    description = "List of Private Subnets IDs"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "container_name" {
    description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}
variable "container_image" {
    description = "The image used to start the container."
}
variable "container_cpu" {
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
    description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
    default     = 1024 # 1 vCPU
     
}
variable "container_memory" {
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
    description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
    default     = 8192 # 8 GB
}
variable "container_memory_reservation" {
    # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
    description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
    default     = 2048 # 2 GB
}
variable "essential" {
    type        = "string"
    description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
    default     = "true"
}
variable "container_port" {
    description = "Port on which the container is listening"
}
locals {
    port_mappings = [
        {
            "containerPort" = "${var.container_port}"
            "hostPort"      = "${var.container_port}"
            "protocol"      = "HTTP"
        }
    ]
}
variable "healthcheck" {
    type        = "map"
    description = "A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
    default     = {}
}
variable "entrypoint" {
    type        = "list"
    description = "The entry point that is passed to the container"
    default     = [ "" ]
}
variable "command" {
    type        = "list"
    description = "The command that is passed to the container"
    default     = [ "" ]
}
variable "working_directory" {
    type        = "string"
    description = "The working directory to run commands inside the container"
    default     = ""
}
variable "environment" {
    type        = "list"
    description = "The environment variables to pass to the container. This is a list of maps. Each map should contain `name` and `value`"
    default     = []
}
variable "secrets" {
    type        = "list"
    description = "The secrets to pass to the container. This is a list of maps"
    default     = []
}
variable "readonly_root_filesystem" {
    type        = "string"
    description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
    default     = "false"
}
locals {
    log_driver  = "awslogs"
    log_options = {
        "awslogs-region"        = "${var.region}"
        "awslogs-group"         = "/ecs/service/${var.name_preffix}"
        "awslogs-stream-prefix" = "ecs"
    }
}
variable "mount_points" {
    type        = "list"
    description = "Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
    default     = []
}
variable "dns_servers" {
    type        = "list"
    description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers."
    default     = []
}
