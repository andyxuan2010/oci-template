variable "compartment_id" {
  description = "Tenancy OCID where the dynamic group is created."
  type        = string
}

variable "name" {
  description = "Dynamic group name."
  type        = string
}

variable "description" {
  description = "Dynamic group description."
  type        = string
}

variable "matching_rule" {
  description = "OCI dynamic group matching rule."
  type        = string
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
