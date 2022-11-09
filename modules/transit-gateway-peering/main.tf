locals {
  same_region            = data.aws_region.this.name == data.aws_region.peer.name
  same_account           = data.aws_caller_identity.this.account_id == data.aws_caller_identity.peer.account_id
  same_acount_and_region = local.same_region && local.same_account

  #local_tgw = element(var.local_transit_gateway, 0)
  #peer_tgw  = element(var.peer_transit_gateway, 0)
  local_tgw = var.local_transit_gateway
  peer_tgw  = var.peer_transit_gateway
}

# Get account and region info
# This is really just to create the "side" tag on the peering attachment
data "aws_caller_identity" "this" {}

data "aws_caller_identity" "peer" {
  provider = aws.peer
}

data "aws_region" "peer" {
  provider = aws.peer
}

data "aws_region" "this" {}

################################################################################
## TRANSIT GATEWAY PEERING ATTACHMENT                                         ##
################################################################################
resource "aws_ec2_transit_gateway_peering_attachment" "this" {
  peer_region             = local.peer_tgw["region"]
  peer_transit_gateway_id = local.peer_tgw["transit_gateway_id"]
  transit_gateway_id      = local.local_tgw["transit_gateway_id"]

  peer_account_id = try(local.peer_tgw["account_id"], null)

  tags = merge(
    var.tags,
    {
      "Name" = var.name
      "Side" = local.same_acount_and_region ? "both" : "requester"
    },
    var.peering_attachment_tags,
    try(local.local_tgw["tags"], {})
  )
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "this" {
  provider = aws.peer

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.this.id

  tags = merge(
    var.tags,
    {
      "Name" = var.name
      "Side" = "accepter"
    },
    var.peering_attachment_tags,
    try(local.peer_tgw["tags"], {})
  )
}

################################################################################
## TRANSIT GATEWAY PEERING ATTACHMENT ROUTES                                  ##
################################################################################
resource "aws_ec2_transit_gateway_route" "this" {
  for_each = toset(local.peer_tgw.prefixes)

  destination_cidr_block         = each.key
  transit_gateway_route_table_id = local.local_tgw.transit_gateway_rtb_id

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment_accepter.this.id
}

resource "aws_ec2_transit_gateway_route" "peer" {
  for_each = toset(local.local_tgw.prefixes)
  provider = aws.peer

  destination_cidr_block         = each.key
  transit_gateway_route_table_id = local.peer_tgw.transit_gateway_rtb_id

  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment_accepter.this.id
}
