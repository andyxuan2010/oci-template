variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID."
  type        = string
}

variable "display_name" {
  description = "NSG display name."
  type        = string
}

variable "ingress_rules" {
  description = "Ingress NSG security rules."
  type = list(object({
    protocol    = string
    source      = string
    source_type = optional(string, "CIDR_BLOCK")
    stateless   = optional(bool, false)
    description = optional(string)
    tcp_options = optional(object({ min = number, max = number }))
    udp_options = optional(object({ min = number, max = number }))
    icmp_options = optional(object({
      type = number
      code = optional(number)
    }))
  }))
  default = []
}

variable "egress_rules" {
  description = "Egress NSG security rules."
  type = list(object({
    protocol         = string
    destination      = string
    destination_type = optional(string, "CIDR_BLOCK")
    stateless        = optional(bool, false)
    description      = optional(string)
    tcp_options      = optional(object({ min = number, max = number }))
    udp_options      = optional(object({ min = number, max = number }))
    icmp_options = optional(object({
      type = number
      code = optional(number)
    }))
  }))
  default = []
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
