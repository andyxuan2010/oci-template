variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "vault_id" {
  description = "Vault OCID."
  type        = string
  nullable    = false
}

variable "key_id" {
  description = "Symmetric encryption key OCID in the Vault."
  type        = string
  nullable    = false
}

variable "secret_name" {
  description = "Secret name."
  type        = string
  nullable    = false
}

variable "secret_content" {
  description = "Plaintext secret value; encoded once by this module."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "description" {
  description = "Secret description."
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
