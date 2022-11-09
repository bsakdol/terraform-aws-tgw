provider "aws" {
  region = "us-west-2"
  alias  = "us_west_2"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

provider "aws" {
  region = "us-east-2"
  alias  = "us_east_2"
}

provider "aws" {
  region = "eu-central-1"
  alias  = "eu_central_1"
}

locals {

  transit_gateways = [
    {
      "region"                 = "us-west-2"
      "transit_gateway_id"     = module.uswest2.id
      "transit_gateway_rtb_id" = module.uswest2.association_default_route_table_id
      "prefixes"               = ["10.102.0.0/16", "10.104.0.0/16"]
    },
    {
      "region"                 = "us-east-2"
      "transit_gateway_id"     = module.useast2.id
      "transit_gateway_rtb_id" = module.useast2.association_default_route_table_id
      "prefixes"               = ["10.101.0.0/16"]
    },
    {
      "region"                 = "eu-central-1"
      "transit_gateway_id"     = module.eucentral1.id
      "transit_gateway_rtb_id" = module.eucentral1.association_default_route_table_id
      "prefixes"               = ["10.105.0.0/16"]
      "tags"                   = { "Description" = "Test environment" }
    },
    {
      "region"                 = "us-east-1"
      "transit_gateway_id"     = module.useast1.id
      "transit_gateway_rtb_id" = module.useast1.association_default_route_table_id
      "prefixes"               = ["10.100.0.0/16", "10.103.0.0/16"]
    },
  ]

}

################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
module "uswest2" {
  source = "../../"

  providers = { aws = aws.us_west_2 }

  name = "uswest2-playground"

  amazon_side_asn                 = 65530
  auto_accept_shared_attachments  = true
  default_route_table_association = true
  description                     = "Transit Gateway development testing"

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "useast2" {
  source = "../../"

  providers = { aws = aws.us_east_2 }

  name = "useast2-playground"

  amazon_side_asn                 = 65532
  auto_accept_shared_attachments  = true
  default_route_table_association = true
  description                     = "Transit Gateway development testing"

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "eucentral1" {
  source = "../../"

  providers = { aws = aws.eu_central_1 }

  name = "eucentral1-playground"

  amazon_side_asn                 = 65533
  auto_accept_shared_attachments  = true
  default_route_table_association = true
  description                     = "Transit Gateway development testing"

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "useast1" {
  source = "../../"

  providers = { aws = aws.us_east_1 }

  name = "useast1-playground"

  amazon_side_asn                 = 65531
  auto_accept_shared_attachments  = true
  default_route_table_association = true
  description                     = "Transit Gateway development testing"

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

################################################################################
## TRANSIT GATEWAY PEERING                                                    ##
################################################################################
# FROM US-WEST-2
module "uswest2_to_useast2" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.us_west_2
    aws.peer = aws.us_east_2
  }

  name = "uswest2::useast2"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-west-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "us-east-2"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "uswest2_to_eucentral1" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.us_west_2
    aws.peer = aws.eu_central_1
  }

  name = "uswest2::eucentral1"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-west-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "eu-central-1"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "uswest2_to_useast1" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.us_west_2
    aws.peer = aws.us_east_1
  }

  name = "uswest2::useast1"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-west-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "us-east-1"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

# FROM US-EAST-2
module "useast2_to_eucentral1" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.us_east_2
    aws.peer = aws.eu_central_1
  }

  name = "useast2::eucentral1"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-east-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "eu-central-1"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

module "useast2_to_useast1" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.us_east_2
    aws.peer = aws.us_east_1
  }

  name = "useast2::useast1"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-east-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "us-east-1"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}

# FROM EU-CENTRAL-1
module "eucentral1_to_useast1" {
  source = "../../modules/transit-gateway-peering"

  providers = {
    aws      = aws.eu_central_1
    aws.peer = aws.us_east_1
  }

  name = "eucentral1::useast1"

  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "eu-central-1"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "us-east-1"][0]

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}
