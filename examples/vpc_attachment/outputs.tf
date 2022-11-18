################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT                                             ##
################################################################################
output "id" {
  description = "EC2 Transit Gateway Attachment identifier."
  value       = module.tgw_vpc_attachment.id
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = module.tgw_vpc_attachment.tags_all
}

output "transit_gateway_vpc_attachment_all" {
  description = "A map of Transit Gateway VPC attachment attributes."
  value       = module.tgw_vpc_attachment.transit_gateway_vpc_attachment_all
}

output "vpc_owner_id" {
  description = "Identifier of the AWS account that owns the EC2 VPC."
  value       = module.tgw_vpc_attachment.vpc_owner_id
}

################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT ROUTES                                      ##
################################################################################
output "transit_gateway_vpc_attachment_routes_all" {
  description = "A map of Transit Gateway VPC attachment routes attributes."
  value       = module.tgw_vpc_attachment.transit_gateway_vpc_attachment_routes_all
}
