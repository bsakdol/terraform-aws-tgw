# AWS Transit Gateway VPC Attachment Terraform Sub-Module

Terraform module for managing AWS Transit Gateway VPC attachments and routing.

## Usage

**IMPORTANT NOTE:** The `main` branch is used as the module source for the usage examples, in place of the version. It is important to pin the release tag (e.g. `?ref=tags/x.y.z`) for the module to the source, when using any portion of this module to provision resources. The `main` branch may contain undocumented breaking changes.

```hcl
module "tgw_vpc_attachment" {
  source = "../../modules/vpc-attachment"

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
    Name        = "useast2-vpc-example"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}

```

## Peering Attachment Routing

The `transit_gateway_routes` variable is a list of maps to define what routes should be populated in the VPC routing tables. While the `aws_route` resource has many options available, the ones available for use within this module are defined as:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="destination_cidr_block"></a> [destination\_cidr\_block](#destination\_cidr\_block) | The destination CIDR block. | `string` | `null` | no |
| <a name="destination_prefix_list_id"></a> [destination\_prefix\_list\_id](#destination\_prefix\_list\_id) | The ID of a managed prefix list destination. | `string` | `null` | no |
| <a name="transit_gateway_id"></a> [transit\_gateway\_id](#transit\_gateway\_id) | Identifier of an EC2 Transit Gateway. | `string` | `null` | yes |
| <a name="vpc_route_table_id"></a> [vpc\_route\_table\_id](#vpc\_route\_table\_id) | Identifier of a VPC route table. | `string` | `null` | yes |

_NOTE: Only specify one of `destination_cidr_block` or `destination_prefix_list_id` for a single peering attachment route. Do not define both attributes in the same map. However, `destination_cidr_block` should take priority over `destination_prefix_list_id` in the event both attributes are defined within the same map._

## Examples

- [VPC Attachment](../../examples/vpc_attachment/)

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

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ec2_transit_gateway_vpc_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.cidr_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.prefix_list](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_appliance_mode_support"></a> [appliance\_mode\_support](#input\_appliance\_mode\_support) | Whether Appliance Mode support is enabled. If enabled, a traffic flow<br>between a source and destination uses the same Availability Zone for the VPC<br>attachment for the lifetime of that flow. | `bool` | `false` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether DNS support is enabled. | `bool` | `true` | no |
| <a name="input_ipv6_support"></a> [ipv6\_support](#input\_ipv6\_support) | Whether IPv6 support is enabled. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used as an identifier of all managed resources. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of EC2 Subnet Identifiers where the attachment will be provisioned.<br>Only one subnet ID is allowed for each availability zone. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the resource. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_default_route_table_association"></a> [transit\_gateway\_default\_route\_table\_association](#input\_transit\_gateway\_default\_route\_table\_association) | Boolean whether the VPC Attachment should be associated with the EC2<br>Transit Gateway association default route table. This cannot be configured<br>or perform drift detection with Resource Access Manager shared EC2 Transit <br>Gateways. | `bool` | `true` | no |
| <a name="input_transit_gateway_default_route_table_propagation"></a> [transit\_gateway\_default\_route\_table\_propagation](#input\_transit\_gateway\_default\_route\_table\_propagation) | Boolean whether the VPC Attachment should propagate routes with the EC2<br>Transit Gateway propagation default route table. This cannot be configured<br>or perform drift detection with Resource Access Manager shared EC2 Transit<br>Gateways. | `bool` | `true` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | Identifier of EC2 Transit Gateway. | `string` | `null` | no |
| <a name="input_transit_gateway_routes"></a> [transit\_gateway\_routes](#input\_transit\_gateway\_routes) | The routes to be configured in the VPC route tables. Either the<br>`destination_cidr_block` or `destination_prefix_list_id` must be configured<br>for each map of attributes. | <pre>list(object({<br>    destination_cidr_block     = optional(string, null)<br>    destination_prefix_list_id = optional(string, null)<br>    transit_gateway_id         = string<br>    vpc_route_table_id         = string<br>  }))</pre> | <pre>[<br>  {<br>    "destination_cidr_block": null,<br>    "destination_prefix_list_id": null,<br>    "transit_gateway_id": null,<br>    "vpc_route_table_id": null<br>  }<br>]</pre> | no |
| <a name="input_vpc_attachment_tags"></a> [vpc\_attachment\_tags](#input\_vpc\_attachment\_tags) | A map of tags to assign to the VPC attachment resource. Resource specific<br>tags will override all other tags. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Identifier of EC2 VPC. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | EC2 Transit Gateway Attachment identifier. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_transit_gateway_vpc_attachment_all"></a> [transit\_gateway\_vpc\_attachment\_all](#output\_transit\_gateway\_vpc\_attachment\_all) | A map of Transit Gateway VPC attachment attributes. |
| <a name="output_transit_gateway_vpc_attachment_routes_all"></a> [transit\_gateway\_vpc\_attachment\_routes\_all](#output\_transit\_gateway\_vpc\_attachment\_routes\_all) | A map of Transit Gateway VPC attachment routes attributes. |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | Identifier of the AWS account that owns the EC2 VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
