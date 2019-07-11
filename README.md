# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

[![CircleCI](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate/tree/master.svg?style=svg)](https://circleci.com/gh/jnonino/terraform-aws-ecs-fargate/tree/master)

## Usage

Check valid versions on:
* Github Releases: <https://github.com/jnonino/terraform-aws-ecs-fargate/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/ecs-fargate/aws>

        module "ecs-fargate": 
            source              = "jnonino/ecs-fargate/aws"
            version             = "2.0.3"
            name_preffix        = var.name_preffix
            profile             = var.profile
            region              = var.region
            vpc_id              = module.networking.vpc_id
            availability_zones  = var.availability_zones
            public_subnets_ids  = module.networking.public_subnets_ids
            private_subnets_ids = module.networking.private_subnets_ids
            container_name               = "${var.name_preffix}-sonar"
            container_image              = "<IMAGE_NAME>:<IMAGE_TAG>"
            container_cpu                = 1024
            container_memory             = 8192
            container_memory_reservation = 2048
            essential                    = true
            container_port               = 9000
            environment = [
                {
                    name  = "<VARIABLE_NAME>"
                    value = "<VARIABLE_VALUE>"
                }
            ]
        }

The networking module should look like this:

        module "networking" {
    		source          = "jnonino/networking/aws"
            version         = "2.0.2"
            name_preffix    = "base"
            profile         = "aws_profile"
            region          = "us-east-1"
            vpc_cidr_block  = "192.168.0.0/16"
            availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
            public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
            private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
    	}

Check versions for this module on:
* Github Releases: <https://github.com/jnonino/terraform-aws-networking/releases>
* Terraform Module Registry: <https://registry.terraform.io/modules/jnonino/networking/aws>

## Output values

* lb_id: Load Balancer ID.
* lb_arn: Load Balancer ARN.
* lb_arn_suffix: Load Balancer ARN Suffix.
* lb_dns_name: Load Balancer DNS Name.
* lb_zone_id: Load Balancer Zone ID.
* lb_sg_id: Load Balancer Security Group - The ID of the security group.
* lb_sg_arn: Load Balancer Security Group - The ARN of the security group.
* lb_sg_name: Load Balancer Security Group - The name of the security group.
* lb_sg_description: Load Balancer Security Group - The description of the security group.
* ecs_tasks_sg_id: ECS Tasks Security Group - The ID of the security group.
* ecs_tasks_sg_arn: ECS Tasks Security Group - The ARN of the security group.
* ecs_tasks_sg_name: ECS Tasks Security Group - The name of the security group.
* ecs_tasks_sg_description: ECS Tasks Security Group - The description of the security group.
