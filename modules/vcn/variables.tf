variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "VCN display name."
  type        = string
  nullable    = false
}

variable "cidr_blocks" {
  description = "IPv4 CIDR blocks assigned to the VCN."
  type        = list(string)
  validation {
    condition     = length(var.cidr_blocks) > 0 && alltrue([for cidr in var.cidr_blocks : can(cidrnetmask(cidr))])
    error_message = "Supply one or more valid IPv4 CIDRs."
  }
  nullable = false
}

variable "dns_label" {
  description = "DNS label for the VCN. Must be unique in the compartment."
  type        = string
  default     = null
  nullable    = true
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
