variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "vcn_id" {
  description = "VCN OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Route table display name."
  type        = string
  nullable    = false
}

variable "enable_internet_gateway" {
  description = "Create an internet gateway."
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_nat_gateway" {
  description = "Create a NAT gateway."
  type        = bool
  default     = false
  nullable    = false
}

variable "route_rules" {
  description = "Route rules. Use network_entity values internet_gateway, nat_gateway, or an OCID."
  type = list(object({
    destination      = string
    destination_type = optional(string, "CIDR_BLOCK")
    network_entity   = string
    description      = optional(string)
  }))
  default  = []
  nullable = false
}

variable "freeform_tags" {
  description = "OCI freeform tags."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "defined_tags" {
  description = "OCI defined tags."
  type        = map(string)
  default     = {}
  nullable    = false
}
