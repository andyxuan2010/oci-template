variable "compartment_id" {
  description = "Compartment OCID where the policy is created."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Policy name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Policy description."
  type        = string
  nullable    = false
}

variable "statements" {
  description = "OCI IAM policy statements."
  type        = list(string)
  validation {
    condition     = length(var.statements) > 0 && alltrue([for statement in var.statements : length(trimspace(statement)) > 0])
    error_message = "Supply at least one nonempty IAM statement; review least privilege separately."
  }
  nullable = false
}

variable "version_date" {
  description = "Optional policy language version date."
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
