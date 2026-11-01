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
  description = "NSG display name."
  type        = string
  nullable    = false
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
  validation {
    condition = alltrue([for rule in var.ingress_rules :
      (rule.tcp_options == null ? true : rule.protocol == "6" && rule.tcp_options.min >= 0 && rule.tcp_options.max <= 65535 && rule.tcp_options.min <= rule.tcp_options.max) &&
      (rule.udp_options == null ? true : rule.protocol == "17" && rule.udp_options.min >= 0 && rule.udp_options.max <= 65535 && rule.udp_options.min <= rule.udp_options.max)
    ])
    error_message = "Port ranges must match TCP/UDP protocol, be ordered, and stay within 0-65535."
  }
  nullable = false
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
  validation {
    condition = alltrue([for rule in var.egress_rules :
      (rule.tcp_options == null ? true : rule.protocol == "6" && rule.tcp_options.min >= 0 && rule.tcp_options.max <= 65535 && rule.tcp_options.min <= rule.tcp_options.max) &&
      (rule.udp_options == null ? true : rule.protocol == "17" && rule.udp_options.min >= 0 && rule.udp_options.max <= 65535 && rule.udp_options.min <= rule.udp_options.max)
    ])
    error_message = "Port ranges must match TCP/UDP protocol, be ordered, and stay within 0-65535."
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

variable "allow_unrestricted_management_ingress" {
  description = "Explicit exception permitting world-accessible management ports or all-protocol ingress. Prefer restricted client CIDRs."
  type        = bool
  default     = false
  nullable    = false
}
