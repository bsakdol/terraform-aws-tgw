provider "aws" {
  region = "us-east-2"
}

################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
module "useast2" {
  source = "../../"

  name = "simple-example"

  tags = {
    "Description" = "bsakdol tgw v0.3.0 test"
    "Owner"       = "bsakdol"
    "Terraform"   = "true"
  }
}
