variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "availability_domain" {
  description = "Availability domain name."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Instance display name."
  type        = string
  nullable    = false
}

variable "shape" {
  description = "Compute shape."
  type        = string
  nullable    = false
}

variable "ocpus" {
  description = "OCPUs for flexible shapes."
  type        = number
  default     = null
  validation {
    condition     = var.ocpus == null ? true : var.ocpus > 0
    error_message = "ocpus must be positive when supplied."
  }
  nullable = true
}

variable "memory_in_gbs" {
  description = "Memory in GBs for flexible shapes."
  type        = number
  default     = null
  validation {
    condition     = var.memory_in_gbs == null ? true : var.memory_in_gbs > 0
    error_message = "memory_in_gbs must be positive when supplied."
  }
  nullable = true
}

variable "image_ocid" {
  description = "Source image OCID."
  type        = string
  validation {
    condition     = length(trimspace(var.image_ocid)) > 0
    error_message = "An explicit source image OCID is required."
  }
  nullable = false
}

variable "subnet_id" {
  description = "Subnet OCID."
  type        = string
  nullable    = false
}

variable "nsg_ids" {
  description = "NSG OCIDs attached to the primary VNIC."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "assign_public_ip" {
  description = "Assign a public IP to the primary VNIC."
  type        = bool
  default     = false
  nullable    = false
}

variable "ssh_public_key" {
  description = "SSH public key injected into the default opc user."
  type        = string
  validation {
    condition     = can(regex("^(ssh-(rsa|ed25519)|ecdsa-sha2-[^ ]+) [A-Za-z0-9+/=]+", trimspace(var.ssh_public_key)))
    error_message = "Provide an OpenSSH public key, never a private key."
  }
  nullable = false
}

variable "boot_volume_size_in_gbs" {
  description = "Optional boot volume size."
  type        = number
  default     = null
  nullable    = true
}

variable "cloud_init" {
  description = "Optional cloud-init content."
  type        = string
  default     = null
  sensitive   = true
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

variable "are_legacy_imds_endpoints_disabled" {
  description = "Disable legacy unauthenticated instance metadata endpoints; use IMDSv2."
  type        = bool
  default     = true
  nullable    = false
}

variable "is_pv_encryption_in_transit_enabled" {
  description = "Encrypt paravirtualized boot/data volume traffic; requires a compatible image and shape."
  type        = bool
  default     = true
  nullable    = false
}
