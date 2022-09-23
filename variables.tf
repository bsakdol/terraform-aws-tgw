variable "amazon_side_asn" {
  type        = number
  default     = 64512
  description = <<-EOT
    Private Autonomous System Number (ASN) for the Amazon side of a BGP session.
    The range is `64512` to `65534` for 16-bit ASNs and `4200000000` to
    `4294967294` for 32-bit ASNs.
  EOT
}

variable "auto_accept_shared_attachments" {
  type        = bool
  default     = false
  description = "Whether resource attachment requests are automatically accepted."
}

variable "default_route_table_association" {
  type        = bool
  default     = true
  description = <<-EOT
    Whether resource attachments are automatically associated with the default
    association route table.
  EOT
}

variable "default_route_table_propagation" {
  type        = bool
  default     = true
  description = <<-EOT
    Whether resource attachments automatically propagate routes to the default
    propagation route table.
  EOT
}

variable "description" {
  type        = string
  default     = null
  description = "Description of the EC2 Transit Gateway."
}

variable "dns_support" {
  type        = bool
  default     = true
  description = "Whether DNS support is enabled."
}

variable "manage_tgw" {
  type        = bool
  default     = true
  description = "A boolean flag to control whether or not to manage TGW resources."
}

variable "multicast_support" {
  type        = bool
  default     = false
  description = "Whether multicast is enabled."
}

variable "name" {
  type        = string
  default     = null
  description = "Name to be used as an identifier of all managed resources."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Key-value tags for the EC2 Transit Gateway. If configured with a provider
    `default_tags` configuration block present, tags with matching keys will
    overwrite those defined at the provider-level.
  EOT
}

variable "timeouts" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Create, update, and delete timeout configuration options for the Transit Gateway.
  EOT
}

variable "transit_gateway_cidr_blocks" {
  type        = list(string)
  default     = []
  description = <<-EOT
    One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a
    size /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger
    for IPv6.
  EOT
}

variable "transit_gateway_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the TGW resource. Resource specific tags will
    override all other tags.
  EOT
}

variable "vpn_ecmp_support" {
  type        = bool
  default     = true
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled."
}
