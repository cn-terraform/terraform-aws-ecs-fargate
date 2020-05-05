provider "aws" {
  region = "us-east-1"
}

module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  version                                     = "2.0.7"
  name_preffix                                = "test-networking"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d" ]
  public_subnets_cidrs_per_availability_zone  = [ "192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19" ]
  private_subnets_cidrs_per_availability_zone = [ "192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19" ]
}

module "test" {
  source              = "../../"
  name_preffix        = "test"
  vpc_id              = module.base-network.vpc_id
  container_image     = "ubuntu"
  container_name      = "test"
  public_subnets_ids  = module.base-network.public_subnets_ids
  private_subnets_ids = module.base-network.private_subnets_ids
}
