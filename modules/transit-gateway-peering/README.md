# AWS Transit Gateway Peering Terraform Sub-Module

Terraform module for managing AWS Transit Gateway peering attachments and routing

## Usage

**IMPORTANT NOTE:** The `main` branch is used as the module source for the usage examples, in place of the version. It is important to pin the release tag (e.g. `?ref=tags/x.y.z`) for the module to the source, when using any portion of this module to provision resources. The `main` branch may contain undocumented breaking changes.

```hcl
provider "aws" {
  region = "us-west-2"
  alias  = "us_west_2"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

module "tgw_peering" {
  source = "https://github.com/bsakdol/terraform-aws-tgw//modules/transit-gateway-peering?ref=main"

  providers = {
    aws      = aws.us_west_2
    aws.peer = aws.us_east_1
  }

  name = "uswest2::useast1"

  local_transit_gateway = {
    prefixes               = ["10.102.0.0/16", "10.104.0.0/16"]
    region                 = "us-west-2"
    transit_gateway_id     = "tgw-123456789"
    transit_gateway_rtb_id = "rtb-123456789"
    tags                   = { "Description" = "demo tgw peering requester" }
  }

  peer_transit_gateway = {
    prefixes               = ["10.100.0.0/16", "10.103.0.0/16"]
    region                 = "us-east-1"
    transit_gateway_id     = "tgw-987654321"
    transit_gateway_rtb_id = "rtb-987654321"
  }

  peering_attachment_tags = {
    "Environment" = "dev"
  }

  tags = {
    "Owner"     = "bsakdol"
    "Terraform" = "true"
  }
}
```

## Providers

The peering attachment requires two different provider definitions:

- **aws**: The provider for the requester side Transit Gateway. If the requester side Transit Gateway is handled by the default provider, this attribute may be ommitted from the provider configuration block within the module.
- **aws.peer**: The provider for the accepter side Transit Gateway.

## Peering Attachment

Each Transit Gateway peering attachment is defined in its own module configuration block. Due to a [limitation with Terraform](https://support.hashicorp.com/hc/en-us/articles/6304194229267-Dynamic-provider-configuration), dynamically passed provider configuration is not currently possible (e.g. a single module configuration block that passes the provider configuration to the resource module). In a production environment, this means it is possible to have tens of module configuration blocks to define the peering attachments.

In an effort to minimize the amount of manual effort required to provision Transit Gateway peering attachments, there are two common options for passing the attributes to each module configuration block.

### Option 1: Passing attributes from a map

Instead of defining each attribute within `local_transit_gateway` and `peer_transit_gateway`, a list of maps containing relevant Transit Gateway information can be difined as a `local`.

```hcl
locals {
  transit_gateways = [
    {
      "region"                 = "us-west-2"
      "transit_gateway_id"     = "tgw-123456789"
      "transit_gateway_rtb_id" = "rtb-123456789"
      "prefixes"               = ["10.102.0.0/16", "10.104.0.0/16"]
    },
    {
      "region"                 = "us-east-2"
      "transit_gateway_id"     = "tgw-987654321"
      "transit_gateway_rtb_id" = "rtb-987654321"
      "prefixes"               = ["10.101.0.0/16"]
    },
  ]
}
```

This configuration method makes it a bit easier to keep track of all the information that requires changes from one module configuration block to the next because the individual map within `local.transit_gateways` can be passed to `var.local_transit_gateway` and `var.peer_transit_gateway`. Using the example configuration above, the peering attachment is able to be defined with the below values.

```hcl
module "peering" {
  <configuration ommitted for brevity>
  
  local_transit_gateway = [for x in local.transit_gateways : x if x.region == "us-west-2"][0]
  peer_transit_gateway  = [for x in local.transit_gateways : x if x.region == "us-east-2"][0]

  <configuration ommitted for brevity>
}
```

Using this method to define the peering attachment, the only values that require a change are the region names within `var.local_transit_gateway` and `var.peer_transit_gateway`. Additionally, we only want to pass in element `0` because the variable definition is a `map()` and we are passing in a list of a single element.

### Option 2: Defining individual attributes

As seen in the [usage](#usage) example, each attribute of the peering attachment may also be defined within the module configuration block. Both `var.local_transit_gateway` and `var.peer_transit_gateway` require the same attributes be defined.

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="account_id"></a> [account\_id](#account\_id) | Account ID of EC2 Transit Gateway to peer with. Defaults to the account ID the AWS provider is currently connected to. | `string` | `null` | no |
| <a name="prefixes"></a> [prefixes](#prefixes) | A list of prefixes attached to the Transit Gateway. These prefixes will be routed across the peering attachment to this Transit Gateway (i.e. the prefixes defined in `var.local_transit_gateway` will be routed from `peer_transit_gateway` to `local_transit_gateway`). | `list(string)` | | yes |
| <a name="region"></a> [region](#region) | Region of the EC2 Transit Gateway. | `string` |  | yes |
| <a name="tags"></a> [tags](#tags) | Key-value tags for the EC2 Transit Gateway Peering attachment. These tags will only apply to the peering attachment side they are defined on (e.g. local TGW or peer TGW). | `map(string)` | `{}` | no |
| <a name="transit_gateway_id"></a> [transit\_gateway\_id](#transit\_gateway\_id) | ID of the Transit Gateway. | `string` |  | yes |
| <a name="transit_gateway_rtb_id"></a> [transit\_gateway\_rtb\_id](#transit\_gateway\_rtb\_id) | ID of the Transit Gateway route table where the peering attachment routes should be provisioned. | `string` |  | yes |

## Examples

- [Transit Gateway Peering](../../examples/transit_gateway_peering/)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.8 |
| <a name="provider_aws.peer"></a> [aws.peer](#provider\_aws.peer) | >= 4.8 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_peering_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_peering_attachment) | resource |
| [aws_ec2_transit_gateway_peering_attachment_accepter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_peering_attachment_accepter) | resource |
| [aws_ec2_transit_gateway_route.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_ec2_transit_gateway_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_route) | resource |
| [aws_caller_identity.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_caller_identity.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_region.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_local_transit_gateway"></a> [local\_transit\_gateway](#input\_local\_transit\_gateway) | Configuration attributes for the Transit Gateway peering attachment. | <pre>object({<br>    account_id             = optional(string, null)<br>    prefixes               = list(string)<br>    region                 = string<br>    tags                   = optional(map(string), {})<br>    transit_gateway_id     = string<br>    transit_gateway_rtb_id = string<br>  })</pre> | <pre>{<br>  "prefixes": [],<br>  "region": null,<br>  "transit_gateway_id": null,<br>  "transit_gateway_rtb_id": null<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used as an identifier of all managed resources. | `string` | `null` | no |
| <a name="input_peer_transit_gateway"></a> [peer\_transit\_gateway](#input\_peer\_transit\_gateway) | Configuration attributes for the Transit Gateway peering attachment. | <pre>object({<br>    account_id             = optional(string, null)<br>    prefixes               = list(string)<br>    region                 = string<br>    tags                   = optional(map(string), {})<br>    transit_gateway_id     = string<br>    transit_gateway_rtb_id = string<br>  })</pre> | <pre>{<br>  "prefixes": [],<br>  "region": null,<br>  "transit_gateway_id": null,<br>  "transit_gateway_rtb_id": null<br>}</pre> | no |
| <a name="input_peering_attachment_tags"></a> [peering\_attachment\_tags](#input\_peering\_attachment\_tags) | A map of tags to assign to the TGW peering attachment resource. Resource<br>specific tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value tags for the EC2 Transit Gateway peering attachment. If configured<br>with a provider `default_tags` configuration block present, tags with<br>matching keys will overwrite those defined at the provider-level. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_peer_transit_gateway_routes"></a> [peer\_transit\_gateway\_routes](#output\_peer\_transit\_gateway\_routes) | A map of peer Transit Gateway peering routes. |
| <a name="output_peering_attachment"></a> [peering\_attachment](#output\_peering\_attachment) | A map of peering attachment attributes. |
| <a name="output_peering_attachment_accepter"></a> [peering\_attachment\_accepter](#output\_peering\_attachment\_accepter) | A map of peering attachment accepter attributes. |
| <a name="output_transit_gateway_routes"></a> [transit\_gateway\_routes](#output\_transit\_gateway\_routes) | A map of Transit Gateway peering routes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
