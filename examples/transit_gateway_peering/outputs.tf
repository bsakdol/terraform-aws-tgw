################################################################################
## US-WEST-2 TRANSIT GATEWAY                                                  ##
################################################################################
output "arn" {
  description = "EC2 Transit Gateway Amazon Resource Name (ARN)."
  value       = module.uswest2.arn
}

output "association_default_route_table_id" {
  description = "Identifier of the default association route table."
  value       = module.uswest2.association_default_route_table_id
}

output "id" {
  description = "EC2 Transit Gateway identifier."
  value       = module.uswest2.id
}

output "owner_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = module.uswest2.owner_id
}

output "propagation_default_route_table_id" {
  description = "Identifier of the AWS account that owns the EC2 Transit Gateway."
  value       = module.uswest2.propagation_default_route_table_id
}

output "tags_all" {
  description = <<-EOT
    A map of tags assigned to the resource, including those inherited from the
    provider `default_tags` configuration block.
  EOT
  value       = module.uswest2.tags_all
}

output "tgw_all" {
  description = "A map of TGW attributes."
  value       = module.uswest2.tgw_all
}

################################################################################
## US-WEST-2::US-EAST-2 TRANSIT GATEWAY PEERING ATTACHMENTS                   ##
################################################################################
output "peering_attachment" {
  description = "A map of peering attachment attributes."
  value       = module.uswest2_to_useast2.peering_attachment
}

output "peering_attachment_accepter" {
  description = "A map of peering attachment accepter attributes."
  value       = module.uswest2_to_useast2.peering_attachment_accepter
}

################################################################################
## US-WEST-2::US-EAST-2 TRANSIT GATEWAY PEERING ATTACHMENT ROUTES             ##
################################################################################
output "transit_gateway_routes" {
  description = "A map of Transit Gateway peering routes."
  value       = module.uswest2_to_useast2.transit_gateway_routes
}

output "peer_transit_gateway_routes" {
  description = "A map of peer Transit Gateway peering routes."
  value       = module.uswest2_to_useast2.peer_transit_gateway_routes
}
