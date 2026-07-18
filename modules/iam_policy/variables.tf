variable "compartment_id" {
  description = "Compartment OCID where the policy is created."
  type        = string
}

variable "name" {
  description = "Policy name."
  type        = string
}

variable "description" {
  description = "Policy description."
  type        = string
}

variable "statements" {
  description = "OCI IAM policy statements."
  type        = list(string)
}

variable "version_date" {
  description = "Optional policy language version date."
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
