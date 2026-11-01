variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "management_endpoint" {
  description = "Vault management endpoint."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Key display name."
  type        = string
  nullable    = false
}

variable "algorithm" {
  description = "Key algorithm."
  type        = string
  default     = "AES"
  nullable    = false
}

variable "length" {
  description = "Key length in bytes; AES-256 uses 32 bytes."
  type        = number
  default     = 32
  nullable    = false
}

variable "curve_id" {
  description = "Curve ID for asymmetric EC keys."
  type        = string
  default     = null
  nullable    = true
}

variable "protection_mode" {
  description = "Key protection mode."
  type        = string
  default     = "HSM"
  nullable    = false
}

variable "is_auto_rotation_enabled" {
  description = "Whether automatic key rotation is enabled."
  type        = bool
  default     = false
  nullable    = false
}

variable "rotation_interval_in_days" {
  description = "Automatic key rotation interval in days."
  type        = number
  default     = null
  nullable    = true
}

variable "time_of_schedule_start" {
  description = "Optional RFC3339 timestamp for automatic key rotation schedule start."
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
