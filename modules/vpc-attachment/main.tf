locals {
  cidr_block_routes  = [for x in var.transit_gateway_routes : x if x.destination_cidr_block != null]
  prefix_list_routes = [for x in var.transit_gateway_routes : x if x.destination_prefix_list_id != null && x.destination_cidr_block == null]
}

################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT                                             ##
################################################################################
resource "aws_ec2_transit_gateway_vpc_attachment" "this" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id

  appliance_mode_support                          = var.appliance_mode_support ? "enable" : "disable"
  dns_support                                     = var.dns_support ? "enable" : "disable"
  ipv6_support                                    = var.ipv6_support ? "enable" : "disable"
  transit_gateway_default_route_table_association = var.transit_gateway_default_route_table_association
  transit_gateway_default_route_table_propagation = var.transit_gateway_default_route_table_propagation

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
    var.vpc_attachment_tags
  )
}

################################################################################
## VPC TRANSIT GATEWAY ATTACHMENT ROUTES                                      ##
################################################################################
resource "aws_route" "cidr_block" {
  for_each = length(local.cidr_block_routes) > 0 ? { for x in local.cidr_block_routes : format("%v-%v", x["vpc_route_table_id"], x["destination_cidr_block"]) => x } : {}

  route_table_id     = each.value["vpc_route_table_id"]
  transit_gateway_id = each.value["transit_gateway_id"]

  destination_cidr_block = each.value["destination_cidr_block"]

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.this
  ]
}

resource "aws_route" "prefix_list" {
  for_each = length(local.prefix_list_routes) > 0 ? { for x in local.prefix_list_routes : format("%v-%v", x["vpc_route_table_id"], x["destination_prefix_list_id"]) => x } : {}

  route_table_id     = each.value["vpc_route_table_id"]
  transit_gateway_id = each.value["transit_gateway_id"]

  destination_prefix_list_id = each.value["destination_prefix_list_id"]

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.this
  ]
}
