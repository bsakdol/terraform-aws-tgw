################################################################################
## TRANSIT GATEWAY PEERING ATTACHMENT                                         ##
################################################################################
output "peering_attachment" {
  description = "A map of peering attachment attributes."
  value       = try(aws_ec2_transit_gateway_peering_attachment.this, null)
}

output "peering_attachment_accepter" {
  description = "A map of peering attachment accepter attributes."
  value       = try(aws_ec2_transit_gateway_peering_attachment_accepter.this, null)
}

################################################################################
## TRANSIT GATEWAY PEERING ATTACHMENT ROUTES                                  ##
################################################################################
output "transit_gateway_routes" {
  description = "A map of Transit Gateway peering routes."
  value       = try(aws_ec2_transit_gateway_route.this, null)
}

output "peer_transit_gateway_routes" {
  description = "A map of peer Transit Gateway peering routes."
  value       = try(aws_ec2_transit_gateway_route.peer, null)
}
