variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "target_subnet_id" {
  description = "OCID of the subnet containing private targets."
  type        = string
}

variable "bastion_type" {
  description = "Bastion type, normally STANDARD or INTERNAL."
  type        = string
  default     = "STANDARD"

  validation {
    condition     = contains(["STANDARD", "INTERNAL"], var.bastion_type)
    error_message = "bastion_type must be STANDARD or INTERNAL."
  }
}

variable "name" {
  description = "Bastion name."
  type        = string
}

variable "client_cidr_block_allow_list" {
  description = "CIDR blocks allowed to create sessions through a standard bastion."
  type        = list(string)
  default     = []
}

variable "max_session_ttl_in_seconds" {
  description = "Maximum lifetime of a bastion session."
  type        = number
  default     = 10800

  validation {
    condition     = var.max_session_ttl_in_seconds >= 1800 && var.max_session_ttl_in_seconds <= 10800
    error_message = "max_session_ttl_in_seconds must be between 1800 and 10800."
  }
}

variable "dns_proxy_status" {
  description = "DNS proxy status for an internal bastion."
  type        = string
  default     = null
}

variable "static_jump_host_ip_addresses" {
  description = "Static jump-host IP addresses for an internal bastion."
  type        = list(string)
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
