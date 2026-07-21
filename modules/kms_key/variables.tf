variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "management_endpoint" {
  description = "Vault management endpoint."
  type        = string
}

variable "display_name" {
  description = "Key display name."
  type        = string
}

variable "algorithm" {
  description = "Key algorithm."
  type        = string
  default     = "AES"
}

variable "length" {
  description = "Key length in bits for symmetric keys."
  type        = number
  default     = 32
}

variable "curve_id" {
  description = "Curve ID for asymmetric EC keys."
  type        = string
  default     = null
}

variable "protection_mode" {
  description = "Key protection mode."
  type        = string
  default     = "HSM"
}

variable "is_auto_rotation_enabled" {
  description = "Whether automatic key rotation is enabled."
  type        = bool
  default     = false
}

variable "rotation_interval_in_days" {
  description = "Automatic key rotation interval in days."
  type        = number
  default     = null
}

variable "time_of_schedule_start" {
  description = "Optional RFC3339 timestamp for automatic key rotation schedule start."
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
