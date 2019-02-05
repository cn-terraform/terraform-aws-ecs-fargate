# AWS ECS Fargate Terraform Module #

This Terraform module deploys an AWS ECS Fargate service.

## Usage

    module "ecs-fargate: 
        source              = "jnonino/ecs-fargate/aws"
        version             = "1.0.0"
        name_preffix        = "${var.name_preffix}"
        profile             = "${var.profile}"
        region              = "${var.region}"
        vpc_id              = "${module.networking.vpc_id}"
        availability_zones  = [ "${var.availability_zones}" ]
        public_subnets_ids  = [ "${module.networking.public_subnets_ids}" ]
        private_subnets_ids = [ "${module.networking.private_subnets_ids}" ]
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
