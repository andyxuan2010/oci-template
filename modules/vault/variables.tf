variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "display_name" {
  description = "Vault display name."
  type        = string
}

variable "vault_type" {
  description = "Vault type."
  type        = string
  default     = "DEFAULT"
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
