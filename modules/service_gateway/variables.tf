variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "vcn_id" {
  description = "VCN OCID."
  type        = string
}

variable "display_name" {
  description = "Service gateway display name."
  type        = string
}

variable "services" {
  description = "OCI service OCIDs to enable on the service gateway."
  type = list(object({
    service_id = string
  }))
}

variable "route_table_id" {
  description = "Optional route table OCID associated with the service gateway."
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
