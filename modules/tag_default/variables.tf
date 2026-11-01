variable "compartment_id" {
  description = "OCID of the compartment where the tag default applies."
  type        = string
  nullable    = false
}

variable "tag_definition_id" {
  description = "OCID of the tag definition used by the default."
  type        = string
  nullable    = false
}

variable "value" {
  description = "Default tag value."
  type        = string
  nullable    = false
}

variable "is_required" {
  description = "Whether resource creation fails when the default tag cannot be applied."
  type        = bool
  default     = false
  nullable    = false
}
