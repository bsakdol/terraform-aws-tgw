provider "aws" {
  region = local.region
}

locals {
  name   = "complete-example"
  region = "us-east-2"
}

################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
module "useast2" {
  source = "../../"

  name = local.name

  amazon_side_asn                 = 65530
  auto_accept_shared_attachments  = true
  default_route_table_association = true
  default_route_table_propagation = true
  description                     = "demo tgw route table"
  dns_support                     = true
  multicast_support               = false
  transit_gateway_cidr_blocks     = ["10.255.255.0/24"]
  vpn_ecmp_support                = true

  timeouts = {
    "create" = "10m"
    "update" = "10m"
    "delete" = "10m"
  }

  transit_gateway_tags = {
    "Owner" = "bsakdol"
  }

  tags = {
    "Description" = "bsakdol tgw v0.3.0 test"
    "Terraform"   = "true"
  }
}
