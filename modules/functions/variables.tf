variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Functions application display name."
  type        = string
  nullable    = false
}

variable "subnet_ids" {
  description = "Private subnet OCIDs for the application."
  type        = list(string)
  validation {
    condition     = length(var.subnet_ids) > 0
    error_message = "At least one subnet is required."
  }
  nullable = false
}

variable "network_security_group_ids" {
  description = "Application NSG OCIDs."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "config" {
  description = "Non-secret application environment configuration."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "functions" {
  description = "Container-image functions keyed by function display name."
  type = map(object({
    image              = string
    memory_in_mbs      = optional(number, 256)
    timeout_in_seconds = optional(number, 30)
    config             = optional(map(string), {})
  }))
  default = {}
  validation {
    condition = alltrue([for f in values(var.functions) :
      length(trimspace(f.image)) > 0 && contains([128, 256, 512, 1024, 2048, 3072], f.memory_in_mbs) &&
      f.timeout_in_seconds >= 5 && f.timeout_in_seconds <= 300 && floor(f.timeout_in_seconds) == f.timeout_in_seconds
    ])
    error_message = "Functions require an image, supported memory size, and integer timeout from 5 to 300 seconds."
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
