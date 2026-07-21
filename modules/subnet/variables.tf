variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID."
  type        = string
}

variable "default_route_table_id" {
  description = "Default route table OCID used when a subnet does not specify route_table_id."
  type        = string
  default     = null
}

variable "default_security_list_ids" {
  description = "Default security-list OCIDs applied to each subnet unless overridden."
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Subnet definitions keyed by logical subnet name."
  type = map(object({
    cidr_block                 = string
    dns_label                  = optional(string)
    prohibit_public_ip_on_vnic = optional(bool, true)
    security_list_ids          = optional(list(string), [])
    route_table_id             = optional(string)
    nsg_ids                    = optional(list(string), [])
  }))
}

variable "freeform_tags" {
  description = "OCI freeform tags."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "OCI defined tags."
  type        = map(string)
  default     = {}
}
