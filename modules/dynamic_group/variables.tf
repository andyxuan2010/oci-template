variable "compartment_id" {
  description = "Tenancy OCID where the dynamic group is created."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Dynamic group name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Dynamic group description."
  type        = string
  nullable    = false
}

variable "matching_rule" {
  description = "OCI dynamic group matching rule."
  type        = string
  validation {
    condition     = length(trimspace(var.matching_rule)) > 0
    error_message = "An explicit dynamic group matching rule is required."
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
