variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Cluster name."
  type        = string
  nullable    = false
}

variable "vcn_id" {
  description = "Cluster VCN OCID."
  type        = string
  nullable    = false
}

variable "kubernetes_version" {
  description = "Region-supported Kubernetes version; select explicitly."
  type        = string
  nullable    = false
}

variable "endpoint_subnet_id" {
  description = "Private subnet OCID for the Kubernetes API endpoint."
  type        = string
  nullable    = false
}

variable "endpoint_nsg_ids" {
  description = "NSGs for the Kubernetes API endpoint."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "kms_key_id" {
  description = "Optional KMS key OCID for Kubernetes secrets."
  type        = string
  default     = null
  nullable    = true
}

variable "node_pools" {
  description = "Managed Flex worker pools with explicit compatible images and private subnet placements."
  type = map(object({
    node_shape     = optional(string, "VM.Standard.E5.Flex")
    ocpus          = optional(number, 1)
    memory_in_gbs  = optional(number, 16)
    image_id       = string
    size           = optional(number, 1)
    nsg_ids        = optional(list(string), [])
    ssh_public_key = optional(string)
    placements = map(object({
      availability_domain = string
      subnet_id           = string
    }))
  }))
  default = {}
  validation {
    condition = alltrue([for p in values(var.node_pools) :
      p.size >= 1 && floor(p.size) == p.size && p.ocpus > 0 && p.memory_in_gbs > 0 &&
      endswith(p.node_shape, ".Flex") && length(trimspace(p.image_id)) > 0 && length(p.placements) > 0
    ])
    error_message = "Each worker pool requires a positive integer size, Flex shape, capacity, image, and at least one placement."
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
