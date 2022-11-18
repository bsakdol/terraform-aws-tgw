################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT                                             ##
################################################################################
output "id" {
  description = "EC2 Transit Gateway Attachment identifier."
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this.id, null)
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this.tags_all, null)
}

output "transit_gateway_vpc_attachment_all" {
  description = "A map of Transit Gateway VPC attachment attributes."
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this, null)
}

output "vpc_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 VPC."
  value       = try(aws_ec2_transit_gateway_vpc_attachment.this.vpc_owner_id, null)
}

################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT ROUTES                                      ##
################################################################################
output "transit_gateway_vpc_attachment_routes_all" {
  description = "A map of Transit Gateway VPC attachment routes attributes."
  value = try(merge(
    try(aws_route.cidr_block, null),
    try(aws_route.prefix_list, null)
  ), null)
}
