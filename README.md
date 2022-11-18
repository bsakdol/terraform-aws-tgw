# terraform-aws-tgw

Terraform module for managing AWS Transit Gateway resources.

## Usage

**IMPORTANT NOTE:** The `main` branch is used as the module source for the usage examples, in place of the version. It is important to pin the release tag (e.g. `?ref=tags/x.y.z`) for the module to the source, when using any portion of this module to provision resources. The `main` branch may contain undocumented breaking changes.

```hcl
module "vpc" {
  source = "https://github.com/bsakdol/terraform-aws-tgw?ref=main"

  name = "example-tgw"

  amazon_side_asn = 65535

  tags = {
    Environment = "development"
    Owner       = "bsakdol"
    Terraform   = "true"
  }
}
```

## Examples

- [Complete](./examples/complete/)
- [Simple](./examples/simple/)
- [Transit Gateway Peering](./example/transit_gateway_peering/)
- [Transit Gateway VPC Attachment](./example/vpc_attachment/)

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
| [aws_ec2_tag.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_transit_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_amazon_side_asn"></a> [amazon\_side\_asn](#input\_amazon\_side\_asn) | Private Autonomous System Number (ASN) for the Amazon side of a BGP session.<br>The range is `64512` to `65534` for 16-bit ASNs and `4200000000` to<br>`4294967294` for 32-bit ASNs. | `number` | `64512` | no |
| <a name="input_auto_accept_shared_attachments"></a> [auto\_accept\_shared\_attachments](#input\_auto\_accept\_shared\_attachments) | Whether resource attachment requests are automatically accepted. | `bool` | `false` | no |
| <a name="input_default_route_table_association"></a> [default\_route\_table\_association](#input\_default\_route\_table\_association) | Whether resource attachments are automatically associated with the default<br>association route table. | `bool` | `true` | no |
| <a name="input_default_route_table_propagation"></a> [default\_route\_table\_propagation](#input\_default\_route\_table\_propagation) | Whether resource attachments automatically propagate routes to the default<br>propagation route table. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the EC2 Transit Gateway. | `string` | `null` | no |
| <a name="input_dns_support"></a> [dns\_support](#input\_dns\_support) | Whether DNS support is enabled. | `bool` | `true` | no |
| <a name="input_manage_tgw"></a> [manage\_tgw](#input\_manage\_tgw) | A boolean flag to control whether or not to manage TGW resources. | `bool` | `true` | no |
| <a name="input_multicast_support"></a> [multicast\_support](#input\_multicast\_support) | Whether multicast is enabled. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be used as an identifier of all managed resources. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Key-value tags for the EC2 Transit Gateway. If configured with a provider<br>`default_tags` configuration block present, tags with matching keys will<br>overwrite those defined at the provider-level. | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create, update, and delete timeout configuration options for the Transit Gateway. | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_cidr_blocks"></a> [transit\_gateway\_cidr\_blocks](#input\_transit\_gateway\_cidr\_blocks) | One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a<br>size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger<br>for IPv6. | `list(string)` | `[]` | no |
| <a name="input_transit_gateway_tags"></a> [transit\_gateway\_tags](#input\_transit\_gateway\_tags) | A map of tags to assign to the TGW resource. Resource specific tags will<br>override all other tags. | `map(string)` | `{}` | no |
| <a name="input_vpn_ecmp_support"></a> [vpn\_ecmp\_support](#input\_vpn\_ecmp\_support) | Whether VPN Equal Cost Multipath Protocol support is enabled. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | EC2 Transit Gateway Amazon Resource Name (ARN). |
| <a name="output_association_default_route_table_id"></a> [association\_default\_route\_table\_id](#output\_association\_default\_route\_table\_id) | Identifier of the default association route table. |
| <a name="output_id"></a> [id](#output\_id) | EC2 Transit Gateway identifier. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | Identifier of the AWS account that owns the EC2 Transit Gateway. |
| <a name="output_propagation_default_route_table_id"></a> [propagation\_default\_route\_table\_id](#output\_propagation\_default\_route\_table\_id) | Identifier of the AWS account that owns the EC2 Transit Gateway. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_tgw_all"></a> [tgw\_all](#output\_tgw\_all) | A map of TGW attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
