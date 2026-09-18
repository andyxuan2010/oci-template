variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "display_name" {
  description = "VCN display name."
  type        = string
}

variable "cidr_blocks" {
  description = "IPv4 CIDR blocks assigned to the VCN."
  type        = list(string)
}

variable "dns_label" {
  description = "DNS label for the VCN. Must be unique in the compartment."
  type        = string
  default     = null
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
