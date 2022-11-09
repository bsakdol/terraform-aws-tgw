variable "local_transit_gateway" {
  type = object({
    account_id             = optional(string, null)
    prefixes               = list(string)
    region                 = string
    tags                   = optional(map(string), {})
    transit_gateway_id     = string
    transit_gateway_rtb_id = string
  })
  default = {
    prefixes               = []
    region                 = null
    transit_gateway_id     = null
    transit_gateway_rtb_id = null
  }
  description = "Configuration attributes for the Transit Gateway peering attachment."
}

variable "name" {
  type        = string
  default     = null
  description = "Name to be used as an identifier of all managed resources."
}

variable "peer_transit_gateway" {
  type = object({
    account_id             = optional(string, null)
    prefixes               = list(string)
    region                 = string
    tags                   = optional(map(string), {})
    transit_gateway_id     = string
    transit_gateway_rtb_id = string
  })
  default = {
    prefixes               = []
    region                 = null
    transit_gateway_id     = null
    transit_gateway_rtb_id = null
  }
  description = "Configuration attributes for the Transit Gateway peering attachment."
}

variable "peering_attachment_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the TGW peering attachment resource. Resource
    specific tags will override all other tags.
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    Key-value tags for the EC2 Transit Gateway peering attachment. If configured
    with a provider `default_tags` configuration block present, tags with
    matching keys will overwrite those defined at the provider-level.
  EOT
}
