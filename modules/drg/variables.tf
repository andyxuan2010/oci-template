variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "DRG display name."
  type        = string
  nullable    = false
}

variable "vcn_attachments" {
  description = "Optional VCN attachments keyed by logical attachment name."
  type = map(object({
    vcn_id                           = string
    display_name                     = optional(string)
    drg_route_table_id               = optional(string)
    route_table_id                   = optional(string)
    export_drg_route_distribution_id = optional(string)
  }))
  default  = {}
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
