variable "appliance_mode_support" {
  type        = bool
  default     = false
  description = <<-EOT
    Whether Appliance Mode support is enabled. If enabled, a traffic flow
    between a source and destination uses the same Availability Zone for the VPC
    attachment for the lifetime of that flow.
  EOT
}

variable "dns_support" {
  type        = bool
  default     = true
  description = "Whether DNS support is enabled."
}

variable "ipv6_support" {
  type        = bool
  default     = false
  description = "Whether IPv6 support is enabled."
}

variable "name" {
  type        = string
  default     = null
  description = "Name to be used as an identifier of all managed resources."
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    List of EC2 Subnet Identifiers where the attachment will be provisioned.
    Only one subnet ID is allowed for each availability zone.
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the resource. If configured with a provider
    `default_tags` configuration block present, tags with matching keys will
    overwrite those defined at the provider-level.
  EOT
}

variable "transit_gateway_default_route_table_association" {
  type        = bool
  default     = true
  description = <<-EOT
    Boolean whether the VPC Attachment should be associated with the EC2
    Transit Gateway association default route table. This cannot be configured
    or perform drift detection with Resource Access Manager shared EC2 Transit 
    Gateways.
  EOT
}

variable "transit_gateway_default_route_table_propagation" {
  type        = bool
  default     = true
  description = <<-EOT
    Boolean whether the VPC Attachment should propagate routes with the EC2
    Transit Gateway propagation default route table. This cannot be configured
    or perform drift detection with Resource Access Manager shared EC2 Transit
    Gateways.
  EOT
}

variable "transit_gateway_id" {
  type        = string
  default     = null
  description = "Identifier of EC2 Transit Gateway."
}

variable "transit_gateway_routes" {
  type = list(object({
    destination_cidr_block     = optional(string, null)
    destination_prefix_list_id = optional(string, null)
    transit_gateway_id         = string
    vpc_route_table_id         = string
  }))
  default = [{
    destination_cidr_block     = null
    destination_prefix_list_id = null
    transit_gateway_id         = null
    vpc_route_table_id         = null
  }]
  description = <<-EOT
    The routes to be configured in the VPC route tables. Either the
    `destination_cidr_block` or `destination_prefix_list_id` must be configured
    for each map of attributes.
  EOT
}

variable "vpc_attachment_tags" {
  type        = map(string)
  default     = {}
  description = <<-EOT
    A map of tags to assign to the VPC attachment resource. Resource specific
    tags will override all other tags.
  EOT
}

variable "vpc_id" {
  type        = string
  default     = null
  description = "Identifier of EC2 VPC."
}
