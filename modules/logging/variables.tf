variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Log group display name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Log group description."
  type        = string
  default     = null
  nullable    = true
}

variable "logs" {
  description = "Service or custom logs keyed by a stable Terraform name."
  type = map(object({
    display_name       = string
    log_type           = optional(string, "SERVICE")
    is_enabled         = optional(bool, true)
    retention_duration = optional(number, 30)
    configuration = optional(object({
      compartment_id = optional(string)
      category       = string
      resource       = string
      service        = string
      source_type    = optional(string, "OCISERVICE")
      parameters     = optional(map(string), {})
    }))
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
