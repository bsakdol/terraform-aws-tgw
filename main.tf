locals {
  tgw_default_rtb_tags = merge(
    var.tags,
    {
      "Name" = format("%v-%v", "tgw-rtb", var.name)
    },
    var.transit_gateway_tags
  )
}

################################################################################
## TRANSIT GATEWAY                                                            ##
################################################################################
resource "aws_ec2_transit_gateway" "this" {
  count = var.manage_tgw ? 1 : 0

  amazon_side_asn                 = var.amazon_side_asn
  auto_accept_shared_attachments  = var.auto_accept_shared_attachments ? "enable" : "disable"
  default_route_table_association = var.default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.default_route_table_propagation ? "enable" : "disable"
  description                     = coalesce(var.description, var.name)
  dns_support                     = var.dns_support ? "enable" : "disable"
  multicast_support               = var.multicast_support ? "enable" : "disable"
  transit_gateway_cidr_blocks     = var.transit_gateway_cidr_blocks
  vpn_ecmp_support                = var.vpn_ecmp_support ? "enable" : "disable"

  timeouts {
    create = try(var.timeouts.create, null)
    update = try(var.timeouts.update, null)
    delete = try(var.timeouts.delete, null)
  }

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.transit_gateway_tags
  )
}

################################################################################
## TRANSIT GATEWAY ROUTE TABLES                                               ##
################################################################################
# Applies tags to the TGW default route table
resource "aws_ec2_tag" "this" {
  for_each = { for k, v in local.tgw_default_rtb_tags : k => v if var.manage_tgw && var.default_route_table_association }

  key         = each.key
  resource_id = aws_ec2_transit_gateway.this[0].association_default_route_table_id
  value       = each.value
}
