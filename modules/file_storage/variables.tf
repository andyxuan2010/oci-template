variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "availability_domain" {
  description = "Availability domain for the file system and mount target."
  type        = string
}

variable "file_system_display_name" {
  description = "File system display name."
  type        = string
}

variable "mount_target_display_name" {
  description = "Mount target display name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet OCID for the mount target."
  type        = string
}

variable "hostname_label" {
  description = "Optional hostname label for the mount target."
  type        = string
  default     = null
}

variable "nsg_ids" {
  description = "NSG OCIDs attached to the mount target."
  type        = list(string)
  default     = []
}

variable "kms_key_id" {
  description = "Optional Vault key OCID for file system encryption."
  type        = string
  default     = null
}

variable "export_path" {
  description = "NFS export path."
  type        = string
  default     = "/export"
}

variable "export_options" {
  description = "Optional NFS export options."
  type = list(object({
    source                         = string
    access                         = optional(string, "READ_WRITE")
    identity_squash                = optional(string, "NONE")
    anonymous_gid                  = optional(number)
    anonymous_uid                  = optional(number)
    allowed_auth                   = optional(list(string))
    is_anonymous_access_allowed    = optional(bool)
    require_privileged_source_port = optional(bool)
  }))
  default = []
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
