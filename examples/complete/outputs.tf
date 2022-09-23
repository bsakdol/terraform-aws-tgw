################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
output "arn" {
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)."
  value       = module.useast2.arn
}

output "association_default_route_table_id" {
  description = "Identifier of the default association route table."
  value       = module.useast2.association_default_route_table_id
}

output "id" {
  description = "EC2 Transit Gateway identifier."
  value       = module.useast2.id
}

output "owner_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = module.useast2.owner_id
}

output "propagation_default_route_table_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = module.useast2.propagation_default_route_table_id
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = module.useast2.tags_all
}

output "tgw_all" {
  description = "A map of TGW attributes."
  value       = module.useast2.tgw_all
}
