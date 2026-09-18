variable "parent_compartment_id" {
  description = "Parent compartment or tenancy OCID."
  type        = string
}

variable "name" {
  description = "Compartment name."
  type        = string
}

variable "description" {
  description = "Compartment description."
  type        = string
}

variable "enable_delete" {
  description = "Allow Terraform destroy to delete the compartment."
  type        = bool
  default     = true
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
