# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![](https://github.com/cn-terraform/terraform-aws-ecs-fargate/workflows/terraform/badge.svg)](https://github.com/cn-terraform/terraform-aws-ecs-fargate/actions?query=workflow%3Aterraform)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate/aws>

## Install pre commit hooks.

Pleas run this command right after cloning the repository.

        pre-commit install

For that you may need to install the folowwing tools:
* [Pre-commit](https://pre-commit.com/)
* [Terraform Docs](https://terraform-docs.io/)

In order to run all checks at any point run the following command:

        pre-commit run --all-files

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecs-cluster"></a> [ecs-cluster](#module\_ecs-cluster) | cn-terraform/ecs-cluster/aws | 1.0.8 |
| <a name="module_ecs-fargate-service"></a> [ecs-fargate-service](#module\_ecs-fargate-service) | cn-terraform/ecs-fargate-service/aws | 2.0.20 |
| <a name="module_td"></a> [td](#module\_td) | cn-terraform/ecs-fargate-task-definition/aws | 1.0.25 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_certificates_arn_for_https_listeners"></a> [additional\_certificates\_arn\_for\_https\_listeners](#input\_additional\_certificates\_arn\_for\_https\_listeners) | (Optional) List of SSL server certificate ARNs for HTTPS listener. Use it if you need to set additional certificates besides default\_certificate\_arn | `list(any)` | `[]` | no |
| <a name="input_assign_public_ip"></a> [assign\_public\_ip](#input\_assign\_public\_ip) | (Optional) Assign a public IP address to the ENI (Fargate launch type only). If true service will be associated with public subnets. Default false. | `bool` | `false` | no |
| <a name="input_command"></a> [command](#input\_command) | The command that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_container_cpu"></a> [container\_cpu](#input\_container\_cpu) | (Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container\_cpu of all containers in a task will need to be lower than the task-level cpu value | `number` | `1024` | no |
| <a name="input_container_definition"></a> [container\_definition](#input\_container\_definition) | Container definition overrides which allows for extra keys or overriding existing keys. | `map(any)` | `{}` | no |
| <a name="input_container_depends_on"></a> [container\_depends\_on](#input\_container\_depends\_on) | The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed. The condition can be one of START, COMPLETE, SUCCESS or HEALTHY | <pre>list(object({<br>    containerName = string<br>    condition     = string<br>  }))</pre> | `[]` | no |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | The image used to start the container. Images in the Docker Hub registry available by default | `string` | n/a | yes |
| <a name="input_container_memory"></a> [container\_memory](#input\_container\_memory) | (Optional) The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container\_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container\_memory of all containers in a task will need to be lower than the task memory value | `number` | `4096` | no |
| <a name="input_container_memory_reservation"></a> [container\_memory\_reservation](#input\_container\_memory\_reservation) | (Optional) The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container\_memory hard limit | `number` | `2048` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, \_ allowed) | `string` | n/a | yes |
| <a name="input_default_certificate_arn"></a> [default\_certificate\_arn](#input\_default\_certificate\_arn) | (Optional) The ARN of the default SSL server certificate. Required if var.https\_ports is set. | `string` | `null` | no |
| <a name="input_deployment_maximum_percent"></a> [deployment\_maximum\_percent](#input\_deployment\_maximum\_percent) | (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. | `number` | `200` | no |
| <a name="input_deployment_minimum_healthy_percent"></a> [deployment\_minimum\_healthy\_percent](#input\_deployment\_minimum\_healthy\_percent) | (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. | `number` | `100` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | (Optional) The number of instances of the task definition to place and keep running. Defaults to 0. | `number` | `1` | no |
| <a name="input_disable_networking"></a> [disable\_networking](#input\_disable\_networking) | When this parameter is true, networking is disabled within the container. | `bool` | `null` | no |
| <a name="input_dns_search_domains"></a> [dns\_search\_domains](#input\_dns\_search\_domains) | Container DNS search domains. A list of DNS search domains that are presented to the container | `list(string)` | `[]` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers | `list(string)` | `[]` | no |
| <a name="input_docker_labels"></a> [docker\_labels](#input\_docker\_labels) | The configuration options to send to the `docker_labels` | `map(string)` | `null` | no |
| <a name="input_docker_security_options"></a> [docker\_security\_options](#input\_docker\_security\_options) | A list of strings to provide custom labels for SELinux and AppArmor multi-level security systems. | `list(string)` | `[]` | no |
| <a name="input_ecs_service_placement_constraints"></a> [ecs\_service\_placement\_constraints](#input\_ecs\_service\_placement\_constraints) | (Optional) rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | `list(any)` | `[]` | no |
| <a name="input_ecs_service_security_groups"></a> [ecs\_service\_security\_groups](#input\_ecs\_service\_security\_groups) | (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used. | `list(any)` | `[]` | no |
| <a name="input_ecs_task_execution_role_custom_policies"></a> [ecs\_task\_execution\_role\_custom\_policies](#input\_ecs\_task\_execution\_role\_custom\_policies) | (Optional) Custom policies to attach to the ECS task execution role. For example for reading secrets from AWS Systems Manager Parameter Store or Secrets Manager | `list(string)` | `[]` | no |
| <a name="input_enable_autoscaling"></a> [enable\_autoscaling](#input\_enable\_autoscaling) | (Optional) If true, autoscaling alarms will be created. | `bool` | `true` | no |
| <a name="input_enable_ecs_managed_tags"></a> [enable\_ecs\_managed\_tags](#input\_enable\_ecs\_managed\_tags) | (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service. | `bool` | `false` | no |
| <a name="input_enable_module"></a> [enable\_module](#input\_enable\_module) | (Optional) Boolean variable to enable or disable the whole module. Defaults to true. | `bool` | `true` | no |
| <a name="input_entrypoint"></a> [entrypoint](#input\_entrypoint) | The entry point that is passed to the container | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The environment variables to pass to the container. This is a list of maps. map\_environment overrides environment | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_environment_files"></a> [environment\_files](#input\_environment\_files) | One or more files containing the environment variables to pass to the container. This maps to the --env-file option to docker run. The file must be hosted in Amazon S3. This option is only available to tasks using the EC2 launch type. This is a list of maps | <pre>list(object({<br>    value = string<br>    type  = string<br>  }))</pre> | `[]` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `true` | no |
| <a name="input_extra_hosts"></a> [extra\_hosts](#input\_extra\_hosts) | A list of hostnames and IP address mappings to append to the /etc/hosts file on the container. This is a list of maps | <pre>list(object({<br>    ipAddress = string<br>    hostname  = string<br>  }))</pre> | `[]` | no |
| <a name="input_firelens_configuration"></a> [firelens\_configuration](#input\_firelens\_configuration) | The FireLens configuration for the container. This is used to specify and configure a log router for container logs. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_FirelensConfiguration.html | <pre>object({<br>    type    = string<br>    options = map(string)<br>  })</pre> | `null` | no |
| <a name="input_health_check_grace_period_seconds"></a> [health\_check\_grace\_period\_seconds](#input\_health\_check\_grace\_period\_seconds) | (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers. | `number` | `0` | no |
| <a name="input_healthcheck"></a> [healthcheck](#input\_healthcheck) | (Optional) A map containing command (string), timeout, interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy), and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries) | <pre>object({<br>    command     = list(string)<br>    retries     = number<br>    timeout     = number<br>    interval    = number<br>    startPeriod = number<br>  })</pre> | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname to use for your container. | `string` | `null` | no |
| <a name="input_interactive"></a> [interactive](#input\_interactive) | When this parameter is true, this allows you to deploy containerized applications that require stdin or a tty to be allocated. | `bool` | `null` | no |
| <a name="input_lb_deregistration_delay"></a> [lb\_deregistration\_delay](#input\_lb\_deregistration\_delay) | (Optional) The amount time for Elastic Load Balancing to wait before changing the state of a deregistering target from draining to unused. The range is 0-3600 seconds. The default value is 300 seconds. | `number` | `300` | no |
| <a name="input_lb_drop_invalid_header_fields"></a> [lb\_drop\_invalid\_header\_fields](#input\_lb\_drop\_invalid\_header\_fields) | (Optional) Indicates whether HTTP headers with header fields that are not valid are removed by the load balancer (true) or routed to targets (false). The default is false. Elastic Load Balancing requires that message header names contain only alphanumeric characters and hyphens. | `bool` | `false` | no |
| <a name="input_lb_enable_cross_zone_load_balancing"></a> [lb\_enable\_cross\_zone\_load\_balancing](#input\_lb\_enable\_cross\_zone\_load\_balancing) | (Optional) If true, cross-zone load balancing of the load balancer will be enabled. Defaults to false. | `bool` | `false` | no |
| <a name="input_lb_enable_deletion_protection"></a> [lb\_enable\_deletion\_protection](#input\_lb\_enable\_deletion\_protection) | (Optional) If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false. | `bool` | `false` | no |
| <a name="input_lb_enable_http2"></a> [lb\_enable\_http2](#input\_lb\_enable\_http2) | (Optional) Indicates whether HTTP/2 is enabled in the load balancer. Defaults to true. | `bool` | `true` | no |
| <a name="input_lb_http_ingress_cidr_blocks"></a> [lb\_http\_ingress\_cidr\_blocks](#input\_lb\_http\_ingress\_cidr\_blocks) | List of CIDR blocks to allowed to access the Load Balancer through HTTP | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_lb_http_ingress_prefix_list_ids"></a> [lb\_http\_ingress\_prefix\_list\_ids](#input\_lb\_http\_ingress\_prefix\_list\_ids) | List of prefix list IDs blocks to allowed to access the Load Balancer through HTTP | `list(string)` | `[]` | no |
| <a name="input_lb_http_ports"></a> [lb\_http\_ports](#input\_lb\_http\_ports) | Map containing objects with two fields, listener\_port and the target\_group\_port to redirect HTTP requests | `map(any)` | <pre>{<br>  "default_http": {<br>    "listener_port": 80,<br>    "target_group_port": 80<br>  }<br>}</pre> | no |
| <a name="input_lb_https_ingress_cidr_blocks"></a> [lb\_https\_ingress\_cidr\_blocks](#input\_lb\_https\_ingress\_cidr\_blocks) | List of CIDR blocks to allowed to access the Load Balancer through HTTPS | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_lb_https_ingress_prefix_list_ids"></a> [lb\_https\_ingress\_prefix\_list\_ids](#input\_lb\_https\_ingress\_prefix\_list\_ids) | List of prefix list IDs blocks to allowed to access the Load Balancer through HTTPS | `list(string)` | `[]` | no |
| <a name="input_lb_https_ports"></a> [lb\_https\_ports](#input\_lb\_https\_ports) | Map containing objects with two fields, listener\_port and the target\_group\_port to redirect HTTPS requests | `map(any)` | <pre>{<br>  "default_http": {<br>    "listener_port": 443,<br>    "target_group_port": 443<br>  }<br>}</pre> | no |
| <a name="input_lb_idle_timeout"></a> [lb\_idle\_timeout](#input\_lb\_idle\_timeout) | (Optional) The time in seconds that the connection is allowed to be idle. Default: 60. | `number` | `60` | no |
| <a name="input_lb_internal"></a> [lb\_internal](#input\_lb\_internal) | (Optional) If true, the LB will be internal. | `bool` | `false` | no |
| <a name="input_lb_ip_address_type"></a> [lb\_ip\_address\_type](#input\_lb\_ip\_address\_type) | (Optional) The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack. Defaults to ipv4 | `string` | `"ipv4"` | no |
| <a name="input_lb_load_balancing_algorithm_type"></a> [lb\_load\_balancing\_algorithm\_type](#input\_lb\_load\_balancing\_algorithm\_type) | (Optional) Determines how the load balancer selects targets when routing requests. The value is round\_robin or least\_outstanding\_requests. The default is round\_robin. | `string` | `"round_robin"` | no |
| <a name="input_lb_security_groups"></a> [lb\_security\_groups](#input\_lb\_security\_groups) | (Optional) A list of security group IDs to assign to the LB. | `list(string)` | `[]` | no |
| <a name="input_lb_slow_start"></a> [lb\_slow\_start](#input\_lb\_slow\_start) | (Optional) The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 0 seconds. | `number` | `0` | no |
| <a name="input_lb_stickiness"></a> [lb\_stickiness](#input\_lb\_stickiness) | (Optional) A Stickiness block. Provide three fields. type, the type of sticky sessions. The only current possible value is lb\_cookie. cookie\_duration, the time period, in seconds, during which requests from a client should be routed to the same target. After this time period expires, the load balancer-generated cookie is considered stale. The range is 1 second to 1 week (604800 seconds). The default value is 1 day (86400 seconds). enabled, boolean to enable / disable stickiness. Default is true. | <pre>object({<br>    type            = string<br>    cookie_duration = string<br>    enabled         = bool<br>  })</pre> | <pre>{<br>  "cookie_duration": 86400,<br>  "enabled": true,<br>  "type": "lb_cookie"<br>}</pre> | no |
| <a name="input_lb_target_group_health_check_enabled"></a> [lb\_target\_group\_health\_check\_enabled](#input\_lb\_target\_group\_health\_check\_enabled) | (Optional) Indicates whether health checks are enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_lb_target_group_health_check_healthy_threshold"></a> [lb\_target\_group\_health\_check\_healthy\_threshold](#input\_lb\_target\_group\_health\_check\_healthy\_threshold) | (Optional) The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3. | `number` | `3` | no |
| <a name="input_lb_target_group_health_check_interval"></a> [lb\_target\_group\_health\_check\_interval](#input\_lb\_target\_group\_health\_check\_interval) | (Optional) The approximate amount of time, in seconds, between health checks of an individual target. Minimum value 5 seconds, Maximum value 300 seconds. Default 30 seconds. | `number` | `30` | no |
| <a name="input_lb_target_group_health_check_matcher"></a> [lb\_target\_group\_health\_check\_matcher](#input\_lb\_target\_group\_health\_check\_matcher) | The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, "200,202") or a range of values (for example, "200-299"). Default is 200. | `string` | `"200"` | no |
| <a name="input_lb_target_group_health_check_path"></a> [lb\_target\_group\_health\_check\_path](#input\_lb\_target\_group\_health\_check\_path) | The destination for the health check request. | `string` | `"/"` | no |
| <a name="input_lb_target_group_health_check_timeout"></a> [lb\_target\_group\_health\_check\_timeout](#input\_lb\_target\_group\_health\_check\_timeout) | (Optional) The amount of time, in seconds, during which no response means a failed health check. The range is 2 to 120 seconds, and the default is 5 seconds. | `number` | `5` | no |
| <a name="input_lb_target_group_health_check_unhealthy_threshold"></a> [lb\_target\_group\_health\_check\_unhealthy\_threshold](#input\_lb\_target\_group\_health\_check\_unhealthy\_threshold) | (Optional) The number of consecutive health check failures required before considering the target unhealthy. Defaults to 3. | `number` | `3` | no |
| <a name="input_links"></a> [links](#input\_links) | List of container names this container can communicate with without port mappings | `list(string)` | `[]` | no |
| <a name="input_linux_parameters"></a> [linux\_parameters](#input\_linux\_parameters) | Linux-specific modifications that are applied to the container, such as Linux kernel capabilities. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LinuxParameters.html | <pre>object({<br>    capabilities = object({<br>      add  = list(string)<br>      drop = list(string)<br>    })<br>    devices = list(object({<br>      containerPath = string<br>      hostPath      = string<br>      permissions   = list(string)<br>    }))<br>    initProcessEnabled = bool<br>    maxSwap            = number<br>    sharedMemorySize   = number<br>    swappiness         = number<br>    tmpfs = list(object({<br>      containerPath = string<br>      mountOptions  = list(string)<br>      size          = number<br>    }))<br>  })</pre> | `null` | no |
| <a name="input_log_configuration"></a> [log\_configuration](#input\_log\_configuration) | Log configuration options to send to a custom log driver for the container. For more details, see https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_LogConfiguration.html | `any` | `null` | no |
| <a name="input_map_environment"></a> [map\_environment](#input\_map\_environment) | The environment variables to pass to the container. This is a map of string: {key: value}. map\_environment overrides environment | `map(string)` | `null` | no |
| <a name="input_mount_points"></a> [mount\_points](#input\_mount\_points) | Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`. The `readOnly` key is optional. | `list(any)` | `[]` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Name prefix for resources on AWS | `any` | n/a | yes |
| <a name="input_ordered_placement_strategy"></a> [ordered\_placement\_strategy](#input\_ordered\_placement\_strategy) | (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered\_placement\_strategy blocks is 5. This is a list of maps where each map should contain "id" and "field" | `list(any)` | `[]` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (Optional) The ARN of the policy that is used to set the permissions boundary for the `ecs_task_execution_role` role. | `string` | `null` | no |
| <a name="input_placement_constraints_task_definition"></a> [placement\_constraints\_task\_definition](#input\_placement\_constraints\_task\_definition) | (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement\_constraints is 10. This is a list of maps, where each map should contain "type" and "expression" | `list(any)` | `[]` | no |
| <a name="input_platform_version"></a> [platform\_version](#input\_platform\_version) | (Optional) The platform version on which to run your service. Defaults to 1.4.0. More information about Fargate platform versions can be found in the AWS ECS User Guide. | `string` | `"1.4.0"` | no |
| <a name="input_port_mappings"></a> [port\_mappings](#input\_port\_mappings) | The port mappings to configure for the container. This is a list of maps. Each map should contain "containerPort", "hostPort", and "protocol", where "protocol" is one of "tcp" or "udp". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort | <pre>list(object({<br>    containerPort = number<br>    hostPort      = number<br>    protocol      = string<br>  }))</pre> | <pre>[<br>  {<br>    "containerPort": 80,<br>    "hostPort": 80,<br>    "protocol": "tcp"<br>  }<br>]</pre> | no |
| <a name="input_private_subnets_ids"></a> [private\_subnets\_ids](#input\_private\_subnets\_ids) | The private subnets associated with the task or service. | `list(any)` | n/a | yes |
| <a name="input_privileged"></a> [privileged](#input\_privileged) | When this variable is `true`, the container is given elevated privileges on the host container instance (similar to the root user). This parameter is not supported for Windows containers or tasks using the Fargate launch type. | `bool` | `null` | no |
| <a name="input_propagate_tags"></a> [propagate\_tags](#input\_propagate\_tags) | (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK\_DEFINITION. Default to SERVICE | `string` | `"SERVICE"` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | (Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain "container\_name", "properties" and "type" | `list(any)` | `[]` | no |
| <a name="input_pseudo_terminal"></a> [pseudo\_terminal](#input\_pseudo\_terminal) | When this parameter is true, a TTY is allocated. | `bool` | `null` | no |
| <a name="input_public_subnets_ids"></a> [public\_subnets\_ids](#input\_public\_subnets\_ids) | The public subnets associated with the task or service. | `list(any)` | n/a | yes |
| <a name="input_readonly_root_filesystem"></a> [readonly\_root\_filesystem](#input\_readonly\_root\_filesystem) | Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value | `bool` | `false` | no |
| <a name="input_repository_credentials"></a> [repository\_credentials](#input\_repository\_credentials) | Container repository credentials; required when using a private repo.  This map currently supports a single key; "credentialsParameter", which should be the ARN of a Secrets Manager's secret holding the credentials | `map(string)` | `null` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | The secrets to pass to the container. This is a list of maps | <pre>list(object({<br>    name      = string<br>    valueFrom = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_registries"></a> [service\_registries](#input\_service\_registries) | (Optional) The service discovery registries for the service. The maximum number of service\_registries blocks is 1. This is a map that should contain the following fields "registry\_arn", "port", "container\_port" and "container\_name" | `map(any)` | `{}` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | (Optional) The name of the SSL Policy for the listener. . Required if var.https\_ports is set. | `string` | `null` | no |
| <a name="input_start_timeout"></a> [start\_timeout](#input\_start\_timeout) | Time duration (in seconds) to wait before giving up on resolving dependencies for a container | `number` | `null` | no |
| <a name="input_stop_timeout"></a> [stop\_timeout](#input\_stop\_timeout) | Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own | `number` | `null` | no |
| <a name="input_system_controls"></a> [system\_controls](#input\_system\_controls) | A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = "", value = ""} | `list(map(string))` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(string)` | `{}` | no |
| <a name="input_ulimits"></a> [ulimits](#input\_ulimits) | Container ulimit settings. This is a list of maps, where each map should contain "name", "hardLimit" and "softLimit" | <pre>list(object({<br>    name      = string<br>    hardLimit = number<br>    softLimit = number<br>  }))</pre> | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | The user to run as inside the container. Can be any of these formats: user, user:group, uid, uid:gid, user:gid, uid:group. The default (null) will use the container's configured `USER` directive or root if not set. | `string` | `null` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | (Optional) A set of volume blocks that containers in your task may use | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_volumes_from"></a> [volumes\_from](#input\_volumes\_from) | A list of VolumesFrom maps which contain "sourceContainer" (name of the container that has the volumes to mount) and "readOnly" (whether the container can write to the volume) | <pre>list(object({<br>    sourceContainer = string<br>    readOnly        = bool<br>  }))</pre> | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `any` | n/a | yes |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The working directory to run commands inside the container | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_ecs_cluster_cluster_arn"></a> [aws\_ecs\_cluster\_cluster\_arn](#output\_aws\_ecs\_cluster\_cluster\_arn) | The Amazon Resource Name (ARN) that identifies the cluster |
| <a name="output_aws_ecs_cluster_cluster_id"></a> [aws\_ecs\_cluster\_cluster\_id](#output\_aws\_ecs\_cluster\_cluster\_id) | The Amazon ID that identifies the cluster |
| <a name="output_aws_ecs_cluster_cluster_name"></a> [aws\_ecs\_cluster\_cluster\_name](#output\_aws\_ecs\_cluster\_cluster\_name) | The name of the cluster |
| <a name="output_aws_ecs_service_service_cluster"></a> [aws\_ecs\_service\_service\_cluster](#output\_aws\_ecs\_service\_service\_cluster) | The Amazon Resource Name (ARN) of cluster which the service runs on. |
| <a name="output_aws_ecs_service_service_desired_count"></a> [aws\_ecs\_service\_service\_desired\_count](#output\_aws\_ecs\_service\_service\_desired\_count) | The number of instances of the task definition |
| <a name="output_aws_ecs_service_service_id"></a> [aws\_ecs\_service\_service\_id](#output\_aws\_ecs\_service\_service\_id) | The Amazon Resource Name (ARN) that identifies the service. |
| <a name="output_aws_ecs_service_service_name"></a> [aws\_ecs\_service\_service\_name](#output\_aws\_ecs\_service\_service\_name) | The name of the service. |
| <a name="output_aws_ecs_task_definition_td_arn"></a> [aws\_ecs\_task\_definition\_td\_arn](#output\_aws\_ecs\_task\_definition\_td\_arn) | Full ARN of the Task Definition (including both family and revision). |
| <a name="output_aws_ecs_task_definition_td_family"></a> [aws\_ecs\_task\_definition\_td\_family](#output\_aws\_ecs\_task\_definition\_td\_family) | The family of the Task Definition. |
| <a name="output_aws_ecs_task_definition_td_revision"></a> [aws\_ecs\_task\_definition\_td\_revision](#output\_aws\_ecs\_task\_definition\_td\_revision) | The revision of the task in a particular family. |
| <a name="output_aws_iam_role_ecs_task_execution_role_arn"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_arn](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_arn) | The Amazon Resource Name (ARN) specifying the role. |
| <a name="output_aws_iam_role_ecs_task_execution_role_create_date"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_create\_date](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_create\_date) | The creation date of the IAM role. |
| <a name="output_aws_iam_role_ecs_task_execution_role_description"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_description](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_description) | The description of the role. |
| <a name="output_aws_iam_role_ecs_task_execution_role_id"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_id](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_id) | The ID of the role. |
| <a name="output_aws_iam_role_ecs_task_execution_role_name"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_name](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_name) | The name of the role. |
| <a name="output_aws_iam_role_ecs_task_execution_role_unique_id"></a> [aws\_iam\_role\_ecs\_task\_execution\_role\_unique\_id](#output\_aws\_iam\_role\_ecs\_task\_execution\_role\_unique\_id) | The stable and unique string identifying the role. |
| <a name="output_aws_lb_lb_arn"></a> [aws\_lb\_lb\_arn](#output\_aws\_lb\_lb\_arn) | The ARN of the load balancer (matches id). |
| <a name="output_aws_lb_lb_arn_suffix"></a> [aws\_lb\_lb\_arn\_suffix](#output\_aws\_lb\_lb\_arn\_suffix) | The ARN suffix for use with CloudWatch Metrics. |
| <a name="output_aws_lb_lb_dns_name"></a> [aws\_lb\_lb\_dns\_name](#output\_aws\_lb\_lb\_dns\_name) | The DNS name of the load balancer. |
| <a name="output_aws_lb_lb_id"></a> [aws\_lb\_lb\_id](#output\_aws\_lb\_lb\_id) | The ARN of the load balancer (matches arn). |
| <a name="output_aws_lb_lb_zone_id"></a> [aws\_lb\_lb\_zone\_id](#output\_aws\_lb\_lb\_zone\_id) | The canonical hosted zone ID of the load balancer (to be used in a Route 53 Alias record). |
| <a name="output_aws_security_group_lb_access_sg_arn"></a> [aws\_security\_group\_lb\_access\_sg\_arn](#output\_aws\_security\_group\_lb\_access\_sg\_arn) | The ARN of the security group |
| <a name="output_aws_security_group_lb_access_sg_description"></a> [aws\_security\_group\_lb\_access\_sg\_description](#output\_aws\_security\_group\_lb\_access\_sg\_description) | The description of the security group |
| <a name="output_aws_security_group_lb_access_sg_egress"></a> [aws\_security\_group\_lb\_access\_sg\_egress](#output\_aws\_security\_group\_lb\_access\_sg\_egress) | The egress rules. |
| <a name="output_aws_security_group_lb_access_sg_id"></a> [aws\_security\_group\_lb\_access\_sg\_id](#output\_aws\_security\_group\_lb\_access\_sg\_id) | The ID of the security group |
| <a name="output_aws_security_group_lb_access_sg_ingress"></a> [aws\_security\_group\_lb\_access\_sg\_ingress](#output\_aws\_security\_group\_lb\_access\_sg\_ingress) | The ingress rules. |
| <a name="output_aws_security_group_lb_access_sg_name"></a> [aws\_security\_group\_lb\_access\_sg\_name](#output\_aws\_security\_group\_lb\_access\_sg\_name) | The name of the security group |
| <a name="output_aws_security_group_lb_access_sg_owner_id"></a> [aws\_security\_group\_lb\_access\_sg\_owner\_id](#output\_aws\_security\_group\_lb\_access\_sg\_owner\_id) | The owner ID. |
| <a name="output_aws_security_group_lb_access_sg_vpc_id"></a> [aws\_security\_group\_lb\_access\_sg\_vpc\_id](#output\_aws\_security\_group\_lb\_access\_sg\_vpc\_id) | The VPC ID. |
| <a name="output_container_name"></a> [container\_name](#output\_container\_name) | Name of the container |
| <a name="output_ecs_tasks_sg_arn"></a> [ecs\_tasks\_sg\_arn](#output\_ecs\_tasks\_sg\_arn) | ${var.name\_prefix} ECS Tasks Security Group - The ARN of the security group |
| <a name="output_ecs_tasks_sg_description"></a> [ecs\_tasks\_sg\_description](#output\_ecs\_tasks\_sg\_description) | ${var.name\_prefix} ECS Tasks Security Group - The description of the security group |
| <a name="output_ecs_tasks_sg_id"></a> [ecs\_tasks\_sg\_id](#output\_ecs\_tasks\_sg\_id) | ${var.name\_prefix} ECS Tasks Security Group - The ID of the security group |
| <a name="output_ecs_tasks_sg_name"></a> [ecs\_tasks\_sg\_name](#output\_ecs\_tasks\_sg\_name) | ${var.name\_prefix} ECS Tasks Security Group - The name of the security group |
| <a name="output_lb_http_listeners_arns"></a> [lb\_http\_listeners\_arns](#output\_lb\_http\_listeners\_arns) | List of HTTP Listeners ARNs |
| <a name="output_lb_http_listeners_ids"></a> [lb\_http\_listeners\_ids](#output\_lb\_http\_listeners\_ids) | List of HTTP Listeners IDs |
| <a name="output_lb_http_tgs_arns"></a> [lb\_http\_tgs\_arns](#output\_lb\_http\_tgs\_arns) | List of HTTP Target Groups ARNs |
| <a name="output_lb_http_tgs_ids"></a> [lb\_http\_tgs\_ids](#output\_lb\_http\_tgs\_ids) | List of HTTP Target Groups IDs |
| <a name="output_lb_http_tgs_names"></a> [lb\_http\_tgs\_names](#output\_lb\_http\_tgs\_names) | List of HTTP Target Groups Names |
| <a name="output_lb_https_listeners_arns"></a> [lb\_https\_listeners\_arns](#output\_lb\_https\_listeners\_arns) | List of HTTPS Listeners ARNs |
| <a name="output_lb_https_listeners_ids"></a> [lb\_https\_listeners\_ids](#output\_lb\_https\_listeners\_ids) | List of HTTPS Listeners IDs |
| <a name="output_lb_https_tgs_arns"></a> [lb\_https\_tgs\_arns](#output\_lb\_https\_tgs\_arns) | List of HTTPS Target Groups ARNs |
| <a name="output_lb_https_tgs_ids"></a> [lb\_https\_tgs\_ids](#output\_lb\_https\_tgs\_ids) | List of HTTPS Target Groups IDs |
| <a name="output_lb_https_tgs_names"></a> [lb\_https\_tgs\_names](#output\_lb\_https\_tgs\_names) | List of HTTPS Target Groups Names |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
