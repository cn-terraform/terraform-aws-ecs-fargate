# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![CircleCI](https://circleci.com/gh/cn-terraform/terraform-aws-ecs-fargate/tree/master.svg?style=svg)](https://circleci.com/gh/cn-terraform/terraform-aws-ecs-fargate/tree/master)
[![](https://img.shields.io/github/license/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/issues/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/issues-closed/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/languages/code-size/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)
[![](https://img.shields.io/github/repo-size/cn-terraform/terraform-aws-ecs-fargate)](https://github.com/cn-terraform/terraform-aws-ecs-fargate)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-ecs-fargate/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/ecs-fargate/aws>

        module "ecs-fargate" {  
            source              = cn-terraform/ecs-fargate/aws
            version             = 2.0.5
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            availability_zones  = module.networking.availability_zones
            public_subnets_ids  = module.networking.public_subnets_ids
            private_subnets_ids = module.networking.private_subnets_ids
            container_name               = ${var.name_preffix}-sonar
            container_image              = <IMAGE_NAME>:<IMAGE_TAG>
            container_cpu                = 1024
            container_memory             = 8192
            container_memory_reservation = 2048
            essential                    = true
            container_port               = 9000
            environment = [
                {
                    name  = <VARIABLE_NAME>
                    value = <VARIABLE_VALUE>
                }
            ]
        }

The networking module should look like this:

        module "networking" { 
    		    source          = cn-terraform/networking/aws
            version         = 2.0.3
            name_preffix    = base
            profile         = aws_profile
            region          = us-east-1
            vpc_cidr_block  = 192.168.0.0/16
            availability_zones                          = [ us-east-1a, us-east-1b, us-east-1c, us-east-1d ]
            public_subnets_cidrs_per_availability_zone  = [ 192.168.0.0/19, 192.168.32.0/19, 192.168.64.0/19, 192.168.96.0/19 ]
            private_subnets_cidrs_per_availability_zone = [ 192.168.128.0/19, 192.168.160.0/19, 192.168.192.0/19, 192.168.224.0/19 ]
    	  }

Check versions for this module on:
* Github Releases: <https://github.com/cn-terraform/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/cn-terraform/networking/aws>

## Input values

* name_preffix: Name preffix for resources on AWS.
* profile: AWS API key credentials to use.
* region: AWS Region the infrastructure is hosted in.
* vpc_id: ID of the VPC.
* subnets: The subnets associated with the task or service.
* ecs_cluster_name = Name of the ECS cluster.
* ecs_cluster_arn: ARN of an ECS cluster.
* container_name: Name of the running container.
* container_port: Port on which the container is listening.
* container_image: The image used to start the container.
* container_name: The name of the container. Up to 255 characters ([a-z], [A-Z], [0-9], -, _ allowed).
* command: (Optional) The command that is passed to the container.
* container_cpu: (Optional) The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value.
* container_depends_on: (Optional) The dependencies defined for container startup and shutdown. A container can contain multiple dependencies. When a dependency is defined for container startup, for container shutdown it is reversed.
* container_memory: (Optional) The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value.
* container_memory_reservation: (Optional) The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit.
* dns_servers: (Optional) Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers.
* entrypoint: (Optional) The entry point that is passed to the container.
* environment: (Optional) The environment variables to pass to the container. This is a list of maps. Each map should contain `name` and `value`.
* essential: (Optional) Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value.
* healthcheck: (Optional) A map containing command (string), interval (duration in seconds), retries (1-10, number of times to retry before marking container unhealthy, and startPeriod (0-300, optional grace period to wait, in seconds, before failed healthchecks count toward retries).
* links: (Optional) List of container names this container can communicate with without port mappings.
* mount_points: (Optional) Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`.
* readonly_root_filesystem: (Optional) Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value.
* repository_credentials: (Optional) Container repository credentials; required when using a private repo.  This map currently supports a single key; credentialsParameter, which should be the ARN of a Secrets Manager's secret holding the credentials.
* secrets: (Optional) The secrets to pass to the container. This is a list of maps.
* stop_timeout: (Optional) Timeout in seconds between sending SIGTERM and SIGKILL to container.
* ulimits: (Optional) Container ulimit settings. This is a list of maps, where each map should contain name, hardLimit and softLimit.
* user: (Optional) The user to run as inside the container. Can be any of these formats:  user, user:group, uid, uid:gid, user:gid, uid:group.
* volumes_from: (Optional) A list of VolumesFrom maps which contain sourceContainer (name of the container that has the volumes to mount) and readOnly (whether the container can write to the volume).
* working_directory: (Optional) The working directory to run commands inside the container.
* placement_constraints: (Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain type and expression.
* proxy_configuration: (Optional) The proxy configuration details for the App Mesh proxy. This is a list of maps, where each map should contain container_name, properties and type
* desired_count: (Optional) The number of instances of the task definition to place and keep running. Defaults to 1.
* platform_version: (Optional) The platform version on which to run your service. Defaults to LATEST. More information about Fargate platform versions can be found in the AWS ECS User Guide.
* deployment_maximum_percent: (Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment.
* deployment_minimum_healthy_percent: (Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment.
* enable_ecs_managed_tags: (Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service.
* propagate_tags: (Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE.
* ordered_placement_strategy: (Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain id and field.
* health_check_grace_period_seconds: (Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers.
* health_check_path: (Optional) The destination for the health check request.
* placement_constraints: (Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain type and expression.
* service_registries: (Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields registry_arn, port, container_port and container_name.
* security_groups: (Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used.
* assign_public_ip: (Optional) Assign a public IP address to the ENI (Fargate launch type only). Valid values are true or false. Default false.

## Output values

* aws_ecs_cluster_cluster_name: The name of the cluster
* aws_ecs_cluster_cluster_id: The Amazon ID that identifies the cluster
* aws_ecs_cluster_cluster_arn: The Amazon Resource Name (ARN) that identifies the cluster
* aws_iam_role_ecs_task_execution_role_arn: The Amazon Resource Name (ARN) specifying the role.
* aws_iam_role_ecs_task_execution_role_create_date: The creation date of the IAM role.
* aws_iam_role_ecs_task_execution_role_description: The description of the role.
* aws_iam_role_ecs_task_execution_role_id: The ID of the role.
* aws_iam_role_ecs_task_execution_role_name: The name of the role.
* aws_iam_role_ecs_task_execution_role_unique_id: The stable and unique string identifying the role.
* aws_ecs_task_definition_td_arn: Full ARN of the Task Definition (including both family and revision).
* aws_ecs_task_definition_td_family: The family of the Task Definition.
* aws_ecs_task_definition_td_revision: The revision of the task in a particular family.
* container_port: Port on which the container is listening
* aws_ecs_service_service_id: The Amazon Resource Name (ARN) that identifies the service. 
* aws_ecs_service_service_name: The name of the service. 
* aws_ecs_service_service_cluster: The Amazon Resource Name (ARN) of cluster which the service runs on. 
* aws_ecs_service_service_desired_count: The number of instances of the task definition 
* lb_id: Load Balancer ID
* lb_arn: Load Balancer ARN
* lb_arn_suffix: Load Balancer ARN Suffix
* lb_dns_name: Load Balancer DNS Name
* lb_zone_id: Load Balancer Zone ID








