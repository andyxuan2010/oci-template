variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Database display name."
  type        = string
  nullable    = false
}

variable "db_name" {
  description = "Database name: 1-14 alphanumeric characters, starting with a letter."
  type        = string
  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9]{0,13}$", var.db_name))
    error_message = "db_name must start with a letter and contain at most 14 alphanumeric characters."
  }
  nullable = false
}

variable "admin_password" {
  description = "ADMIN password meeting OCI password requirements."
  type        = string
  sensitive   = true
  nullable    = false
}

variable "subnet_id" {
  description = "Private endpoint subnet OCID."
  type        = string
  validation {
    condition     = length(trimspace(var.subnet_id)) > 0
    error_message = "A private endpoint subnet OCID is required."
  }
  nullable = false
}

variable "nsg_ids" {
  description = "NSGs controlling database connectivity."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "compute_count" {
  description = "ECPU count."
  type        = number
  default     = 2
  validation {
    condition     = var.compute_count >= 2
    error_message = "At least 2 ECPUs are required."
  }
  nullable = false
}

variable "data_storage_size_in_tbs" {
  description = "Allocated data storage in TB."
  type        = number
  default     = 1
  validation {
    condition     = var.data_storage_size_in_tbs >= 1
    error_message = "Storage must be at least 1 TB."
  }
  nullable = false
}

variable "is_auto_scaling_enabled" {
  description = "Enable compute autoscaling."
  type        = bool
  default     = false
  nullable    = false
}

variable "license_model" {
  description = "LICENSE_INCLUDED or BRING_YOUR_OWN_LICENSE."
  type        = string
  default     = "LICENSE_INCLUDED"
  validation {
    condition     = contains(["LICENSE_INCLUDED", "BRING_YOUR_OWN_LICENSE"], var.license_model)
    error_message = "Unsupported license model."
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
