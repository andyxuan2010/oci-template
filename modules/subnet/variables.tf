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

variable "default_route_table_id" {
  description = "Default route table OCID used when a subnet does not specify route_table_id."
  type        = string
  default     = null
  nullable    = true
}

variable "default_security_list_ids" {
  description = "Default security-list OCIDs applied to each subnet unless overridden."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "subnets" {
  description = "Subnet definitions keyed by logical subnet name."
  type = map(object({
    cidr_block                 = string
    dns_label                  = optional(string)
    prohibit_public_ip_on_vnic = optional(bool, true)
    security_list_ids          = optional(list(string), [])
    route_table_id             = optional(string)
    nsg_ids                    = optional(list(string), []) # Deprecated compatibility field; NSGs attach to VNICs, not subnets.
  }))
  validation {
    condition     = length(var.subnets) > 0 && alltrue([for subnet in values(var.subnets) : can(cidrnetmask(subnet.cidr_block))])
    error_message = "Supply a nonempty subnet map with valid IPv4 CIDRs."
  }
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
