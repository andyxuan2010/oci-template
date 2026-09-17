variable "region" {
  description = "OCI region identifier, for example us-ashburn-1."
  type        = string
}

variable "tenancy_ocid" {
  description = "Root tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "Existing workload compartment OCID. Required when create_compartment is false."
  type        = string
  default     = ""
}

variable "auth" {
  description = "OCI provider authentication method: APIKey, SecurityToken, InstancePrincipal, ResourcePrincipal, or OKEWorkloadIdentity."
  type        = string
  default     = "APIKey"
}

variable "config_file_profile" {
  description = "OCI CLI config profile to use."
  type        = string
  default     = "DEFAULT"
}

variable "user_ocid" {
  description = "OCI user OCID for API key authentication."
  type        = string
  default     = null
}

variable "fingerprint" {
  description = "API key fingerprint for API key authentication."
  type        = string
  default     = null
}

variable "private_key_path" {
  description = "Path to the OCI API private key for API key authentication."
  type        = string
  default     = null
}

variable "private_key" {
  description = "PEM-encoded OCI API private key for API key authentication. Takes precedence over private_key_path."
  type        = string
  default     = null
  sensitive   = true
}

variable "workload" {
  description = "Short workload name used in resource display names."
  type        = string
  default     = "app"
}

variable "environment" {
  description = "Environment name such as dev, test, prod, or shared."
  type        = string
  default     = "dev"
}

variable "create_compartment" {
  description = "Whether to create a child compartment for this workload."
  type        = bool
  default     = true
}

variable "freeform_tags" {
  description = "Common OCI freeform tags."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "Common OCI defined tags."
  type        = map(string)
  default     = {}
}

variable "vcn_cidr_blocks" {
  description = "CIDR blocks for the VCN."
  type        = list(string)
  default     = ["10.20.0.0/16"]
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
}

variable "enable_internet_gateway" {
  description = "Create an internet gateway for public route tables."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Create a NAT gateway for private outbound traffic."
  type        = bool
  default     = true
}

variable "create_compute_instance" {
  description = "Whether to create a sample Linux compute instance."
  type        = bool
  default     = false
}

variable "compute_shape" {
  description = "OCI compute shape."
  type        = string
  default     = "VM.Standard.E5.Flex"
}

variable "compute_ocpus" {
  description = "OCPUs for flexible shapes."
  type        = number
  default     = 1
}

variable "compute_memory_in_gbs" {
  description = "Memory in GBs for flexible shapes."
  type        = number
  default     = 8
}

variable "compute_image_ocid" {
  description = "Image OCID for the compute instance. Required when create_compute_instance is true."
  type        = string
  default     = ""
}

variable "ssh_public_key" {
  description = "SSH public key for the compute instance."
  type        = string
  default     = ""
}

variable "create_object_storage_bucket" {
  description = "Whether to create a sample object storage bucket."
  type        = bool
  default     = true
}

variable "create_vault" {
  description = "Whether to create an OCI Vault."
  type        = bool
  default     = false
}
