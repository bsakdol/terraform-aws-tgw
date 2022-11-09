# Transit Gateway Peering Example

This module builds Transit Gateway peering attachments between Transit Gateway provisioned in the `US-West-2`, `US-East-1`, `US-East-2`, and `EU-Central-1` regions of AWS. The example configuration in this directory provides a sample of each common configuration option available (some of them defaults). For more niche configuration options, it may be necessary to reference the [README](../../modules/transit-gateway-peering/README.md).

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
| <a name="module_eucentral1"></a> [eucentral1](#module\_eucentral1) | ../../ | n/a |
| <a name="module_eucentral1_to_useast1"></a> [eucentral1\_to\_useast1](#module\_eucentral1\_to\_useast1) | ../../modules/transit-gateway-peering | n/a |
| <a name="module_useast1"></a> [useast1](#module\_useast1) | ../../ | n/a |
| <a name="module_useast2"></a> [useast2](#module\_useast2) | ../../ | n/a |
| <a name="module_useast2_to_eucentral1"></a> [useast2\_to\_eucentral1](#module\_useast2\_to\_eucentral1) | ../../modules/transit-gateway-peering | n/a |
| <a name="module_useast2_to_useast1"></a> [useast2\_to\_useast1](#module\_useast2\_to\_useast1) | ../../modules/transit-gateway-peering | n/a |
| <a name="module_uswest2"></a> [uswest2](#module\_uswest2) | ../../ | n/a |
| <a name="module_uswest2_to_eucentral1"></a> [uswest2\_to\_eucentral1](#module\_uswest2\_to\_eucentral1) | ../../modules/transit-gateway-peering | n/a |
| <a name="module_uswest2_to_useast1"></a> [uswest2\_to\_useast1](#module\_uswest2\_to\_useast1) | ../../modules/transit-gateway-peering | n/a |
| <a name="module_uswest2_to_useast2"></a> [uswest2\_to\_useast2](#module\_uswest2\_to\_useast2) | ../../modules/transit-gateway-peering | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | EC2 Transit Gateway Amazon Resource Name (ARN). |
| <a name="output_association_default_route_table_id"></a> [association\_default\_route\_table\_id](#output\_association\_default\_route\_table\_id) | Identifier of the default association route table. |
| <a name="output_id"></a> [id](#output\_id) | EC2 Transit Gateway identifier. |
| <a name="output_owner_id"></a> [owner\_id](#output\_owner\_id) | Identifier of the AWS account that owns the EC2 Transit Gateway. |
| <a name="output_peer_transit_gateway_routes"></a> [peer\_transit\_gateway\_routes](#output\_peer\_transit\_gateway\_routes) | A map of peer Transit Gateway peering routes. |
| <a name="output_peering_attachment"></a> [peering\_attachment](#output\_peering\_attachment) | A map of peering attachment attributes. |
| <a name="output_peering_attachment_accepter"></a> [peering\_attachment\_accepter](#output\_peering\_attachment\_accepter) | A map of peering attachment accepter attributes. |
| <a name="output_propagation_default_route_table_id"></a> [propagation\_default\_route\_table\_id](#output\_propagation\_default\_route\_table\_id) | Identifier of the AWS account that owns the EC2 Transit Gateway. |
| <a name="output_tags_all"></a> [tags\_all](#output\_tags\_all) | A map of tags assigned to the resource, including those inherited from the<br>provider `default_tags` configuration block. |
| <a name="output_tgw_all"></a> [tgw\_all](#output\_tgw\_all) | A map of TGW attributes. |
| <a name="output_transit_gateway_routes"></a> [transit\_gateway\_routes](#output\_transit\_gateway\_routes) | A map of Transit Gateway peering routes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
