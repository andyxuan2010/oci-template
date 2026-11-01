variable "compartment_id" {
  description = "OCID of the compartment that owns the quota policy."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Quota policy name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Quota policy description."
  type        = string
  nullable    = false
}

variable "statements" {
  description = "OCI quota policy statements."
  type        = list(string)

  validation {
    condition     = length(var.statements) > 0
    error_message = "statements must contain at least one quota statement."
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
