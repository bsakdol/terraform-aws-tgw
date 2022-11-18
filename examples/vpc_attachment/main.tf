provider "aws" {
  region = "us-east-2"
}

################################################################################
## TRANSIT GATEWAY VPC ATTACHMENT                                             ##
################################################################################
module "tgw_vpc_attachment" {
  source = "../../modules/vpc-attachment"

  name = "useast2-vpc-example"

  # AWS recommends using an independent, smaller, subnet similar to a /28 for
  # the attachment subnet IDs. For reference to the best practices:
  # https://docs.aws.amazon.com/vpc/latest/tgw/tgw-best-design-practices.html
  subnet_ids = [
    "subnet-0d34038511202d808",
    "subnet-08dd167a7d8c8d2d8"
  ]

  transit_gateway_id = "tgw-0b69e8c71693c44fb"
  vpc_id             = "vpc-0f8e1084eaf4f8484"

  transit_gateway_routes = [
    {
      destination_cidr_block = "10.0.0.0/8"
      transit_gateway_id     = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id     = "rtb-01ba195736fd69ad4"
    },
    {
      destination_cidr_block = "10.0.0.0/8"
      transit_gateway_id     = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id     = "rtb-0a21aa3d237cfe378"
    },
    {
      destination_cidr_block = "10.0.0.0/8"
      transit_gateway_id     = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id     = "rtb-09a519631e899a02a"
    },
    {
      destination_prefix_list_id = "pl-0af146abed9353978"
      transit_gateway_id         = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id         = "rtb-01ba195736fd69ad4"
    },
    {
      destination_prefix_list_id = "pl-0af146abed9353978"
      transit_gateway_id         = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id         = "rtb-0a21aa3d237cfe378"
    },
    {
      destination_prefix_list_id = "pl-0af146abed9353978"
      transit_gateway_id         = "tgw-0b69e8c71693c44fb"
      vpc_route_table_id         = "rtb-09a519631e899a02a"
    },
  ]

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}

################################################################################
## DEPENDENCIES                                                               ##
################################################################################
# Applied with resource targeting to simulate them being provisioned already:
# - terraform apply -target=module.vpc
# - terraform apply -target=module.transit_gateway
module "vpc" {
  source  = "bsakdol/vpc/aws"
  version = "0.1.3"

  name = "useast2-vpc-example"

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  internal_subnets = {
    "10.0.255.0/28" = {
      "availability_zone" = "us-east-2a"
    },
    "10.0.255.16/28" = {
      "availability_zone" = "us-east-2b"
    }
  }

  private_subnets = {
    "10.0.10.0/24" = {
      "availability_zone" = "us-east-2a"
    },
    "10.0.11.0/24" = {
      "availability_zone" = "us-east-2b"
    }
  }

  public_subnets = {
    "10.0.20.0/24" = {
      "availability_zone"  = "us-east-2a"
      "create_nat_gateway" = true
    },
    "10.0.21.0/24" = {
      "availability_zone"  = "us-east-2b"
      "create_nat_gateway" = true
    }
  }

  internal_subnets_tags = { Type = "internal" }
  private_subnets_tags  = { Type = "private" }
  public_subnets_tags   = { Type = "public" }

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}

module "transit_gateway" {
  source = "../../"

  name = "useast2-example"

  tags = {
    "Environment" = "development"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}
