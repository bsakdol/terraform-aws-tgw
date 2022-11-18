# Transit Gateway VPC Attachment Example

This module builds Transit Gateway VPC attachment to a Transit Gateway in the `US-East-2` region of AWS.

## Usage

To provision the environment in this example, the following commands will need to be executed:

```hcl
terraform init
terraform apply
```

When resources are no longer being used, run the following command to destroy them:

```hcl
# terraform destroy
```

_NOTE: Resources in this example may cost money, so it is important to understand AWS pricing prior to provisioning._

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.8 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tgw_vpc_attachment"></a> [tgw\_vpc\_attachment](#module\_tgw\_vpc\_attachment) | ../../modules/vpc-attachment | n/a |
| <a name="module_transit_gateway"></a> [transit\_gateway](#module\_transit\_gateway) | ../../ | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | bsakdol/vpc/aws | 0.1.3 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | EC2 Transit Gateway Attachment identifier. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_transit_gateway_vpc_attachment_all"></a> [transit\_gateway\_vpc\_attachment\_all](#output\_transit\_gateway\_vpc\_attachment\_all) | A map of Transit Gateway VPC attachment attributes. |
| <a name="output_transit_gateway_vpc_attachment_routes_all"></a> [transit\_gateway\_vpc\_attachment\_routes\_all](#output\_transit\_gateway\_vpc\_attachment\_routes\_all) | A map of Transit Gateway VPC attachment routes attributes. |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | Identifier of the AWS account that owns the EC2 VPC. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
