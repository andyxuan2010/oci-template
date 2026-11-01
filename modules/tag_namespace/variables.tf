variable "compartment_id" {
  description = "Tenancy or compartment OCID that owns the tag namespace."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Tag namespace name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Tag namespace description."
  type        = string
  nullable    = false
}

variable "is_retired" {
  description = "Whether the tag namespace is retired."
  type        = bool
  default     = false
  nullable    = false
}

variable "tags" {
  description = "Tag definitions keyed by tag name."
  type = map(object({
    description      = string
    is_cost_tracking = optional(bool, false)
    is_retired       = optional(bool, false)
    validator = optional(object({
      validator_type = string
      values         = list(string)
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
