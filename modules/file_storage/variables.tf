variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "availability_domain" {
  description = "Availability domain for the file system and mount target."
  type        = string
  nullable    = false
}

variable "file_system_display_name" {
  description = "File system display name."
  type        = string
  nullable    = false
}

variable "mount_target_display_name" {
  description = "Mount target display name."
  type        = string
  nullable    = false
}

variable "subnet_id" {
  description = "Subnet OCID for the mount target."
  type        = string
  nullable    = false
}

variable "hostname_label" {
  description = "Optional hostname label for the mount target."
  type        = string
  default     = null
  nullable    = true
}

variable "nsg_ids" {
  description = "NSG OCIDs attached to the mount target."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "kms_key_id" {
  description = "Optional Vault key OCID for file system encryption."
  type        = string
  default     = null
  nullable    = true
}

variable "export_path" {
  description = "NFS export path."
  type        = string
  default     = "/export"
  validation {
    condition     = startswith(var.export_path, "/") && !strcontains(var.export_path, "..")
    error_message = "Use an absolute NFS export path without parent traversal."
  }
  nullable = false
}

variable "export_options" {
  description = "Explicit NFS client rules; at least one restricted source is required."
  type = list(object({
    source                         = string
    access                         = optional(string, "READ_WRITE")
    identity_squash                = optional(string, "ROOT")
    anonymous_gid                  = optional(number)
    anonymous_uid                  = optional(number)
    allowed_auth                   = optional(list(string))
    is_anonymous_access_allowed    = optional(bool, false)
    require_privileged_source_port = optional(bool, true)
  }))
  default = []
  validation {
    condition = length(var.export_options) > 0 && alltrue([for rule in var.export_options :
      can(cidrhost(rule.source, 0)) && try(tonumber(split("/", rule.source)[1]) > 0, false) &&
      contains(["READ_ONLY", "READ_WRITE"], rule.access) && contains(["ROOT", "ALL", "NONE"], rule.identity_squash)
    ])
    error_message = "Supply nonempty export options with explicit IPv4/IPv6 CIDRs narrower than /0, supported access, and identity squash modes."
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
