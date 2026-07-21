variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "availability_domain" {
  description = "Availability domain name."
  type        = string
}

variable "display_name" {
  description = "Instance display name."
  type        = string
}

variable "shape" {
  description = "Compute shape."
  type        = string
}

variable "ocpus" {
  description = "OCPUs for flexible shapes."
  type        = number
  default     = null
}

variable "memory_in_gbs" {
  description = "Memory in GBs for flexible shapes."
  type        = number
  default     = null
}

variable "image_ocid" {
  description = "Source image OCID."
  type        = string
}

variable "subnet_id" {
  description = "Subnet OCID."
  type        = string
}

variable "nsg_ids" {
  description = "NSG OCIDs attached to the primary VNIC."
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Assign a public IP to the primary VNIC."
  type        = bool
  default     = false
}

variable "ssh_public_key" {
  description = "SSH public key injected into the default opc user."
  type        = string
}

variable "boot_volume_size_in_gbs" {
  description = "Optional boot volume size."
  type        = number
  default     = null
}

variable "cloud_init" {
  description = "Optional cloud-init content."
  type        = string
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
