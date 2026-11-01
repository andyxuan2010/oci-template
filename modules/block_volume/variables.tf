variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "availability_domain" {
  description = "Availability domain for the block volume."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Block volume display name."
  type        = string
  nullable    = false
}

variable "size_in_gbs" {
  description = "Block volume size in GB."
  type        = number
  default     = 50
  validation {
    condition     = var.size_in_gbs >= 50 && floor(var.size_in_gbs) == var.size_in_gbs
    error_message = "Volume size must be an integer of at least 50 GB."
  }
  nullable = false
}

variable "vpus_per_gb" {
  description = "Volume performance units per GB."
  type        = number
  default     = 10
  nullable    = false
}

variable "backup_policy_id" {
  description = "Optional volume backup policy OCID."
  type        = string
  default     = null
  nullable    = true
}

variable "kms_key_id" {
  description = "Optional Vault key OCID for volume encryption."
  type        = string
  default     = null
  nullable    = true
}

variable "attach_to_instance_id" {
  description = "Optional compute instance OCID to attach this volume to."
  type        = string
  default     = null
  nullable    = true
}

variable "attachment_type" {
  description = "Volume attachment type."
  type        = string
  default     = "paravirtualized"
  validation {
    condition     = contains(["paravirtualized", "iscsi", "nvme", "service_determined"], var.attachment_type)
    error_message = "Unsupported volume attachment type."
  }
  nullable = false
}

variable "is_read_only" {
  description = "Whether the optional attachment is read-only."
  type        = bool
  default     = false
  nullable    = false
}

variable "is_shareable" {
  description = "Whether the optional attachment is shareable."
  type        = bool
  default     = false
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

variable "is_pv_encryption_in_transit_enabled" {
  description = "Encrypt traffic on paravirtualized attachments; not applied to iSCSI or NVMe."
  type        = bool
  default     = true
  nullable    = false
}
