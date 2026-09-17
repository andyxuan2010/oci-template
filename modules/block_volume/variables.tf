variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "availability_domain" {
  description = "Availability domain for the block volume."
  type        = string
}

variable "display_name" {
  description = "Block volume display name."
  type        = string
}

variable "size_in_gbs" {
  description = "Block volume size in GB."
  type        = number
  default     = 50
}

variable "vpus_per_gb" {
  description = "Volume performance units per GB."
  type        = number
  default     = 10
}

variable "backup_policy_id" {
  description = "Optional volume backup policy OCID."
  type        = string
  default     = null
}

variable "kms_key_id" {
  description = "Optional Vault key OCID for volume encryption."
  type        = string
  default     = null
}

variable "attach_to_instance_id" {
  description = "Optional compute instance OCID to attach this volume to."
  type        = string
  default     = null
}

variable "attachment_type" {
  description = "Volume attachment type."
  type        = string
  default     = "paravirtualized"
}

variable "is_read_only" {
  description = "Whether the optional attachment is read-only."
  type        = bool
  default     = false
}

variable "is_shareable" {
  description = "Whether the optional attachment is shareable."
  type        = bool
  default     = false
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
