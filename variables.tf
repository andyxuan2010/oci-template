variable "region" {
  description = "OCI region identifier, for example us-ashburn-1."
  type        = string
  nullable    = false
}

variable "tenancy_ocid" {
  description = "Root tenancy OCID."
  type        = string
  nullable    = false
}

variable "compartment_ocid" {
  description = "Existing workload compartment OCID. Required when create_compartment is false."
  type        = string
  default     = ""
  validation {
    condition     = var.create_compartment || length(trimspace(var.compartment_ocid)) > 0
    error_message = "Set compartment_ocid when create_compartment is false."
  }
  nullable = false
}

variable "auth" {
  description = "OCI provider authentication method: APIKey, SecurityToken, InstancePrincipal, ResourcePrincipal, or OKEWorkloadIdentity."
  type        = string
  default     = "APIKey"
  validation {
    condition     = contains(["APIKey", "SecurityToken", "InstancePrincipal", "ResourcePrincipal", "OKEWorkloadIdentity"], var.auth)
    error_message = "Unsupported OCI authentication method."
  }
  nullable = false
}

variable "config_file_profile" {
  description = "OCI CLI config profile to use."
  type        = string
  default     = "DEFAULT"
  nullable    = false
}

variable "user_ocid" {
  description = "OCI user OCID for API key authentication."
  type        = string
  default     = null
  nullable    = true
}

variable "fingerprint" {
  description = "API key fingerprint for API key authentication."
  type        = string
  default     = null
  nullable    = true
}

variable "private_key_path" {
  description = "Path to the OCI API private key for API key authentication."
  type        = string
  default     = null
  nullable    = true
}

variable "private_key" {
  description = "PEM-encoded OCI API private key for API key authentication. Takes precedence over private_key_path."
  type        = string
  default     = null
  sensitive   = true
  nullable    = true
}

variable "workload" {
  description = "Short workload name used in resource display names."
  type        = string
  default     = "app"
  validation {
    condition     = can(regex("^[a-z0-9]+(-[a-z0-9]+)*$", var.workload))
    error_message = "Use lowercase alphanumeric workload segments separated by single hyphens."
  }
  nullable = false
}

variable "environment" {
  description = "Environment name such as dev, test, prod, or shared."
  type        = string
  default     = "dev"
  validation {
    condition     = can(regex("^[a-z0-9]+(-[a-z0-9]+)*$", var.environment))
    error_message = "Use lowercase alphanumeric environment segments separated by single hyphens."
  }
  nullable = false
}

variable "create_compartment" {
  description = "Whether to create a child compartment for this workload."
  type        = bool
  default     = true
  nullable    = false
}

variable "freeform_tags" {
  description = "Common OCI freeform tags."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "defined_tags" {
  description = "Common OCI defined tags."
  type        = map(string)
  default     = {}
  nullable    = false
}

variable "vcn_cidr_blocks" {
  description = "CIDR blocks for the VCN."
  type        = list(string)
  default     = ["10.20.0.0/16"]
  nullable    = false
}

variable "subnets" {
  description = "Subnet definitions keyed by logical subnet name."
  type = map(object({
    cidr_block                 = string
    dns_label                  = optional(string)
    prohibit_public_ip_on_vnic = optional(bool, true)
    security_list_ids          = optional(list(string), [])
    route_table_id             = optional(string)
    nsg_ids                    = optional(list(string), [])
  }))
  default = {
    app = {
      cidr_block                 = "10.20.1.0/24"
      dns_label                  = "app"
      prohibit_public_ip_on_vnic = true
    }
  }
  nullable = false
}

variable "enable_internet_gateway" {
  description = "Create an internet gateway for public route tables."
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_nat_gateway" {
  description = "Create a NAT gateway for private outbound traffic."
  type        = bool
  default     = true
  nullable    = false
}

variable "create_compute_instance" {
  description = "Whether to create a sample Linux compute instance."
  type        = bool
  default     = false
  nullable    = false
}

variable "compute_shape" {
  description = "OCI compute shape."
  type        = string
  default     = "VM.Standard.E5.Flex"
  nullable    = false
}

variable "compute_ocpus" {
  description = "OCPUs for flexible shapes."
  type        = number
  default     = 1
  nullable    = false
}

variable "compute_memory_in_gbs" {
  description = "Memory in GBs for flexible shapes."
  type        = number
  default     = 8
  nullable    = false
}

variable "compute_image_ocid" {
  description = "Image OCID for the compute instance. Required when create_compute_instance is true."
  type        = string
  default     = ""
  validation {
    condition     = !var.create_compute_instance || length(trimspace(var.compute_image_ocid)) > 0
    error_message = "Set a region-valid image OCID before enabling compute."
  }
  nullable = false
}

variable "ssh_public_key" {
  description = "SSH public key for the compute instance."
  type        = string
  default     = ""
  validation {
    condition     = !var.create_compute_instance || can(regex("^(ssh-(rsa|ed25519)|ecdsa-sha2-[^ ]+) ", trimspace(var.ssh_public_key)))
    error_message = "Set an OpenSSH public key before enabling compute."
  }
  nullable = false
}

variable "create_object_storage_bucket" {
  description = "Whether to create a sample object storage bucket."
  type        = bool
  default     = true
  nullable    = false
}

variable "create_vault" {
  description = "Whether to create an OCI Vault."
  type        = bool
  default     = false
  nullable    = false
}
