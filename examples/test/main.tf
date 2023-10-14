locals {
  public_subnet_ids  = [for s in module.base-network.public_subnets : s.id]
  private_subnet_ids = [for s in module.base-network.private_subnets : s.id]
}

module "base-network" {
  source     = "cn-terraform/networking/aws"
  cidr_block = "192.168.0.0/16"

  vpc_additional_tags = {
    vpc_tag1 = "tag1",
    vpc_tag2 = "tag2",
  }

  public_subnets = {
    first_public_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.0.0/19"
    }
    second_public_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.32.0/19"
    }
  }

  public_subnets_additional_tags = {
    public_subnet_tag1 = "tag1",
    public_subnet_tag2 = "tag2",
  }

  private_subnets = {
    first_private_subnet = {
      availability_zone = "us-east-1a"
      cidr_block        = "192.168.128.0/19"
    }
    second_private_subnet = {
      availability_zone = "us-east-1b"
      cidr_block        = "192.168.160.0/19"
    }
  }

  private_subnets_additional_tags = {
    private_subnet_tag1 = "tag1",
    private_subnet_tag2 = "tag2",
  }
}

module "test" {
  source              = "../../"
  name_prefix         = "test"
  vpc_id              = module.base-network.vpc_id
  container_image     = "ubuntu"
  container_name      = "test"
  public_subnets_ids  = local.public_subnet_ids
  private_subnets_ids = local.private_subnet_ids
}
