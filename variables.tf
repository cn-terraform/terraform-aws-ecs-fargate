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
# Locals
# ---------------------------------------------------------------------------------------------------------------------

locals {
  log_driver = "awslogs"
  log_options = {
    "awslogs-region"        = var.region
    "awslogs-group"         = "/ecs/service/${var.name_preffix}"
    "awslogs-stream-prefix" = "ecs"
  }
}

locals {
  port_mappings = [
    {
      "containerPort" = var.container_port
      "hostPort"      = var.container_port
      "protocol"      = "HTTP"
    },
  ]
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS Networking
# ---------------------------------------------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the VPC"
}

variable "availability_zones" {
  type        = list
  description = "List of Availability Zones"
}

variable "public_subnets_ids" {
  type        = list
  description = "List of Public Subnets IDs"
}

variable "private_subnets_ids" {
  type        = list
  description = "List of Private Subnets IDs"
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Container Definition Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "container_port" {
  description = "Port on which the container is listening"
}

variable "container_image" {
  description = "The image used to start the container."
}

variable "container_name" {
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}

variable "command" {
  type        = list
  description = "(Optional) The command that is passed to the container"
  default     = [""]
}

variable "container_cpu" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 1024 # 1 vCPU 
}

variable "container_depends_on" {
  type        = list
  description = "(Optional) The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed"
  default     = []
}

variable "container_memory" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = 8192 # 8 GB
}

variable "container_memory_reservation" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = 2048 # 2 GB
}

variable "dns_servers" {
  type        = list
  description = "(Optional) Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers."
  default     = []
}

variable "entrypoint" {
  type        = list
  description = "(Optional) The entry point that is passed to the container"
  default     = [""]
}

variable "environment" {
  type        = list
  description = "(Optional) The environment variables to pass to the container. This is a list of maps. Each map should contain `name` and `value`"
  default     = []
}

variable "essential" {
  type        = string
  description = "(Optional) Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = "true"
}

variable "healthcheck" {
  type        = map
  description = "(Optional) A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  default     = {}
}

variable "links" {
  type        = list
  description = "(Optional) List of container names this container can communicate with without port mappings."
  default     = []
}

variable "mount_points" {
  type        = list
  description = "(Optional) Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
  default     = []
}

variable "readonly_root_filesystem" {
  type        = string
  description = "(Optional) Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = "false"
}

variable "repository_credentials" {
  type        = map
  description = "(Optional) Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  default     = {}
}

variable "secrets" {
  type        = list
  description = "(Optional) The secrets to pass to the container. This is a list of maps"
  default     = []
}

variable "start_timeout" {
  description = "(Optional) Time duration (in seconds) to wait before giving up on resolving dependencies for a container."
  default     = 30
}

variable "stop_timeout" {
  description = "(Optional) Timeout in seconds between sending SIGTERM and SIGKILL to container"
  default     = 30
}

variable "ulimits" {
  type        = list
  description = "(Optional) Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  default     = []
}

variable "user" {
  description = "(Optional) The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group"
  default     = ""
}

variable "volumes_from" {
  type        = list
  description = "(Optional) A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)."
  default     = []
}

variable "working_directory" {
  type        = string
  description = "(Optional) The working directory to run commands inside the container"
  default     = ""
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
# ---------------------------------------------------------------------------------------------------------------------
variable "placement_constraints_task_definition" {
  type        = list
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  default     = []
}

variable "proxy_configuration" {
  type        = list
  description = "(Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain \"container_name\", \"properties\" and \"type\""
  default     = []
}

# ---------------------------------------------------------------------------------------------------------------------
# AWS ECS SERVICE
# ---------------------------------------------------------------------------------------------------------------------
variable "task_definition_arn" {
  description = "(Required) The full ARN of the task definition that you want to run in your service."
}

variable "ecs_cluster_name" {
  description = "Name of the ECS cluster"
}

variable "ecs_cluster_arn" {
  description = "ARN of an ECS cluster"
}

variable "subnets" {
  description = "The subnets associated with the task or service."
  type        = list
}

variable "desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 1."
  type        = number
  default     = 1
}

variable "platform_version" {
  description = "(Optional) The platform version on which to run your service. Defaults to LATEST. More information about Fargate platform versions can be found in the AWS ECS User Guide."
  default     = "LATEST"
}

variable "deployment_maximum_percent" {
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
  default     = 100
}

variable "enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  default     = ""
}

variable "propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE"
  default     = "SERVICE"
}

variable "ordered_placement_strategy" {
  description = "(Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain \"id\" and \"field\""
  type        = list
  default     = []
}

variable "health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  type        = number
  default     = 0
}

variable "placement_constraints_ecs_service" {
  type        = list
  description = "(Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  default     = []
}

variable "service_registries" {
  description = "(Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields \"registry_arn\", \"port\", \"container_port\" and \"container_name\""
  type        = map
  default     = {}
}

variable "security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list
  default     = []
}

variable "assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false."
  type        = bool
  default     = false
}