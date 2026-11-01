variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Repository name, including any namespace path."
  type        = string
  nullable    = false
}

variable "is_public" {
  description = "Allow unauthenticated image pulls."
  type        = bool
  default     = false
  nullable    = false
}

variable "is_immutable" {
  description = "Prevent overwriting existing image tags."
  type        = bool
  default     = true
  nullable    = false
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
