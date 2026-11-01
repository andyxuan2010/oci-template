variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "namespace" {
  description = "Object Storage namespace."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Bucket name."
  type        = string
  nullable    = false
}

variable "access_type" {
  description = "Bucket access type."
  type        = string
  default     = "NoPublicAccess"
  validation {
    condition     = contains(["NoPublicAccess", "ObjectRead", "ObjectReadWithoutList"], var.access_type)
    error_message = "Unsupported access_type value."
  }
  nullable = false
}

variable "storage_tier" {
  description = "Bucket storage tier."
  type        = string
  default     = "Standard"
  validation {
    condition     = contains(["Standard", "Archive"], var.storage_tier)
    error_message = "Unsupported storage_tier value."
  }
  nullable = false
}

variable "versioning" {
  description = "Bucket object versioning: Enabled or Disabled."
  type        = string
  default     = "Enabled"
  validation {
    condition     = contains(["Enabled", "Suspended", "Disabled"], var.versioning)
    error_message = "Unsupported versioning value."
  }
  nullable = false
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

variable "kms_key_id" {
  description = "Optional symmetric KMS key OCID for bucket encryption."
  type        = string
  default     = null
  nullable    = true
}

variable "object_events_enabled" {
  description = "Enable object-level event emission for integration with Events rules."
  type        = bool
  default     = false
  nullable    = false
}
