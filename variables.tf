#------------------------------------------------------------------------------
# Misc
#------------------------------------------------------------------------------
variable "name_preffix" {
  description = "Name preffix for resources on AWS"
}

#------------------------------------------------------------------------------
# AWS Networking
#------------------------------------------------------------------------------
variable "vpc_id" {
  description = "ID of the VPC"
}

#------------------------------------------------------------------------------
# AWS ECS Container Definition Variables
#------------------------------------------------------------------------------
variable "container_image" {
  description = "The image used to start the container."
}

variable "container_name" {
  description = "The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed)"
}

variable "command" {
  description = "(Optional) The command that is passed to the container"
  type        = list(string)
  default     = null
}

variable "container_cpu" {
  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/AWS_Fargate.html#fargate-task-defs
  description = "(Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 1024 # 1 vCPU
}

variable "container_depends_on" {
  description = "(Optional) The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed"
  type = list(object({
    containerName = string
    condition     = string
  }))
  default = null
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
  type        = list(string)
  description = "(Optional) Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers"
  default     = null
}

variable "docker_labels" {
  description = "(Optional) The configuration options to send to the `docker_labels`"
  type        = map(string)
  default     = null
}

variable "entrypoint" {
  description = "(Optional) The entry point that is passed to the container"
  type        = list(string)
  default     = null
}

variable "environment" {
  description = "(Optional) The environment variables to pass to the container. This is a list of maps"
  type = list(object({
    name  = string
    value = string
  }))
  default = null
}

variable "essential" {
  description = "(Optional) Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = true
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html
variable "firelens_configuration" {
  description = "(Optional) The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html"
  type = object({
    type    = string
    options = map(string)
  })
  default = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_HealthCheck.html
variable "healthcheck" {
  description = "(Optional) A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries)"
  type = object({
    command     = list(string)
    retries     = number
    timeout     = number
    interval    = number
    startPeriod = number
  })
  default = null
}

variable "links" {
  description = "(Optional) List of container names this container can communicate with without port mappings"
  type        = list(string)
  default     = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html
variable "linux_parameters" {
  description = "Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html"
  type = object({
    capabilities = object({
      add  = list(string)
      drop = list(string)
    })
    devices = list(object({
      containerPath = string
      hostPath      = string
      permissions   = list(string)
    }))
    initProcessEnabled = bool
    maxSwap            = number
    sharedMemorySize   = number
    swappiness         = number
    tmpfs = list(object({
      containerPath = string
      mountOptions  = list(string)
      size          = number
    }))
  })

  default = null
}

# https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html
variable "log_configuration" {
  description = "(Optional) Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html"
  type = object({
    logDriver = string
    options   = map(string)
    secretOptions = list(object({
      name      = string
      valueFrom = string
    }))
  })
  default = null
}

variable "mount_points" {
  description = "(Optional) Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
  type = list(object({
    containerPath = string
    sourceVolume  = string
  }))
  default = null
}

variable "port_mappings" {
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = [
    {
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }
  ]
}

variable "readonly_root_filesystem" {
  description = "(Optional) Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  type        = bool
  default     = false
}

variable "repository_credentials" {
  description = "(Optional) Container repository credentials; required when using a private repo.  This map currently supports a single key; \"credentialsParameter\", which should be the ARN of a Secrets Manager's secret holding the credentials"
  type        = map(string)
  default     = null
}

variable "secrets" {
  description = "(Optional) The secrets to pass to the container. This is a list of maps"
  type = list(object({
    name      = string
    valueFrom = string
  }))
  default = null
}

variable "start_timeout" {
  description = "(Optional) Time duration (in seconds) to wait before giving up on resolving dependencies for a container."
  default     = 30
}

variable "system_controls" {
  description = "(Optional) A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = \"\", value = \"\"}"
  type        = list(map(string))
  default     = null
}

variable "stop_timeout" {
  description = "(Optional) Timeout in seconds between sending SIGTERM and SIGKILL to container"
  type        = number
  default     = 30
}

variable "ulimits" {
  description = "(Optional) Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  type = list(object({
    name      = string
    hardLimit = number
    softLimit = number
  }))
  default = null
}

variable "user" {
  description = "(Optional) The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group"
  type        = string
  default     = null
}

variable "volumes_from" {
  description = "(Optional) A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)"
  type = list(object({
    sourceContainer = string
    readOnly        = bool
  }))
  default = null
}

variable "working_directory" {
  description = "(Optional) The working directory to run commands inside the container"
  type        = string
  default     = null
}

#------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
#------------------------------------------------------------------------------
variable "placement_constraints_task_definition" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  type        = list
  default     = []
}

variable "proxy_configuration" {
  description = "(Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain \"container_name\", \"properties\" and \"type\""
  type        = list
  default     = []
}

variable "volumes" {
  description = "(Optional) A set of volume blocks that containers in your task may use"
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
    efs_volume_configuration = list(object({
      file_system_id = string
      root_directory = string
    }))
  }))
  default = []
}

#------------------------------------------------------------------------------
# APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
variable "lb_internal" {
  description = "(Optional) If true, the LB will be internal."
  type        = bool
  default     = false
}

variable "lb_security_groups" {
  description = "(Optional) A list of security group IDs to assign to the LB."
  type        = list(string)
  default     = []
}

variable "lb_drop_invalid_header_fields" {
  description = "(Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens."
  type        = bool
  default     = false
}

variable "lb_idle_timeout" {
  description = "(Optional) The time in seconds that the connection is allowed to be idle. Default: 60."
  type        = number
  default     = 60
}

variable "lb_enable_deletion_protection" {
  description = "(Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "lb_enable_cross_zone_load_balancing" {
  description = "(Optional) If true, cross-zone load balancing of the load balancer will be enabled. Defaults to false."
  type        = bool
  default     = false
}

variable "lb_enable_http2" {
  description = "(Optional) Indicates whether HTTP/2 is enabled in the load balancer. Defaults to true."
  type        = bool
  default     = true
}

variable "lb_ip_address_type" {
  description = "(Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. Defaults to ipv4"
  type        = string
  default     = "ipv4"
}

#------------------------------------------------------------------------------
# ACCESS CONTROL TO APPLICATION LOAD BALANCER
#------------------------------------------------------------------------------
variable "lb_enable_http" {
  description = "Enable HTTP Listeners for ports on the variable http_ports. Defaults to true"
  type        = bool
  default     = true
}

variable "lb_http_ports" {
  description = "The list of ports with access to the Load Balancer through HTTP listeners"
  type        = list(number)
  default     = [ 80 ]
}

variable "lb_http_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allowed to access the Load Balancer through HTTP"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "lb_http_ingress_prefix_list_ids" {
  description = "List of prefix list IDs blocks to allowed to access the Load Balancer through HTTP"
  type        = list(string)
  default     = []
}

variable "lb_enable_https" {
  description = "Enable HTTPS Listeners for ports on the variable https_ports. Defaults to true"
  type        = bool
  default     = true
}

variable "lb_https_ports" {
  description = "The list of ports with access to the Load Balancer through HTTPS listeners"
  type        = list(number)
  default     = [ 443 ]
}

variable "lb_https_ingress_cidr_blocks" {
  description = "List of CIDR blocks to allowed to access the Load Balancer through HTTPS"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "lb_https_ingress_prefix_list_ids" {
  description = "List of prefix list IDs blocks to allowed to access the Load Balancer through HTTPS"
  type        = list(string)
  default     = []
}

#------------------------------------------------------------------------------
# AWS LOAD BALANCER - Target Groups
#------------------------------------------------------------------------------
variable "lb_deregistration_delay" {
  description = "(Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds."
  type        = number
  default     = 300
}

variable "lb_slow_start" {
  description = "(Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds."
  type        = number
  default     = 0
}

variable "lb_load_balancing_algorithm_type" {
  description = "(Optional) Determines how the load balancer selects targets when routing requests. The value is round_robin or least_outstanding_requests. The default is round_robin."
  type        = string
  default     = "round_robin"
}

variable "lb_stickiness" {
  description = "(Optional) A Stickiness block. Provide three fields. type, the type of sticky sessions. The only current possible value is lb_cookie. cookie_duration, the time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds). enabled, boolean to enable / disable stickiness. Default is true."
  type = object({
    type            = string
    cookie_duration = string
    enabled         = bool
  })
  default = {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
}

variable "lb_target_group_health_check_enabled" {
  description = "(Optional) Indicates whether health checks are enabled. Defaults to true."
  type        = bool
  default     = true
}

variable "lb_target_group_health_check_interval" {
  description = "(Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds."
  type        = number
  default     = 30
}

variable "lb_target_group_health_check_path" {
  description = "The destination for the health check request."
  type        = string
  default     = "/"
}

variable "lb_target_group_health_check_timeout" {
  description = "(Optional) The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds."
  type        = number
  default     = 5
}

variable "lb_target_group_health_check_healthy_threshold" {
  description = "(Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
  type        = number
  default     = 3
}

variable "lb_target_group_health_check_unhealthy_threshold" {
  description = "(Optional) The number of consecutive health check failures required before considering the target unhealthy. Defaults to 3."
  type        = number
  default     = 3
}

variable "lb_target_group_health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, \"200,202\") or a range of values (for example, \"200-299\"). Default is 200."
  type        = string
  default     = "200"
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE
#------------------------------------------------------------------------------
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

variable "desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0."
  type        = number
  default     = 1
}

variable "enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  type        = bool
  default     = false
}

variable "health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  type        = number
  default     = 0
}

variable "ordered_placement_strategy" {
  description = "(Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain \"id\" and \"field\""
  type        = list
  default     = []
}

variable "ecs_service_placement_constraints" {
  type        = list
  description = "(Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  default     = []
}

variable "platform_version" {
  description = "(Optional) The platform version on which to run your service. Defaults to 1.4.0. More information about Fargate platform versions can be found in the AWS ECS User Guide."
  default     = "1.4.0"
}

variable "propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE"
  default     = "SERVICE"
}

variable "service_registries" {
  description = "(Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields \"registry_arn\", \"port\", \"container_port\" and \"container_name\""
  type        = map
  default     = {}
}

#------------------------------------------------------------------------------
# AWS ECS SERVICE network_configuration BLOCK
#------------------------------------------------------------------------------
variable "public_subnets_ids" {
  description = "The public subnets associated with the task or service."
  type        = list
}

variable "private_subnets_ids" {
  description = "The private subnets associated with the task or service."
  type        = list
}

variable "ecs_service_security_groups" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list
  default     = []
}

variable "assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI (Fargate launch type only). If true service will be associated with public subnets. Default false. "
  type        = bool
  default     = false
}
