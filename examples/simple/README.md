# Simple Transit Gateway Example

This module builds an example Transit Gateway in the `US-East-2` region of AWS. The example configuration in this directory provides a sample of the most basic configuration option available. For more niche configuration options, it may be necessary to reference the main [README](../../README.md).

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
| <a name="module_useast2"></a> [useast2](#module\_useast2) | ../../ | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tgw_all"></a> [tgw\_all](#output\_tgw\_all) | A map of TGW attributes. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
