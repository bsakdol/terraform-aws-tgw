################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
output "arn" {
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)."
  value       = try(aws_ec2_transit_gateway.this[0].arn, null)
}

output "association_default_route_table_id" {
  description = "Identifier of the default association route table."
  value       = try(aws_ec2_transit_gateway.this[0].association_default_route_table_id, null)
}

output "id" {
  description = "EC2 Transit Gateway identifier."
  value       = try(aws_ec2_transit_gateway.this[0].id, null)
}

output "owner_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = try(aws_ec2_transit_gateway.this[0].owner_id, null)
}

output "propagation_default_route_table_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = try(aws_ec2_transit_gateway.this[0].propagation_default_route_table_id, null)
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = try(aws_ec2_transit_gateway.this[0].tags_all, null)
}

output "tgw_all" {
  description = "A map of TGW attributes."
  value       = try(aws_ec2_transit_gateway.this[0], null)
}
