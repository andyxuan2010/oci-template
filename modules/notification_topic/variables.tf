variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "name" {
  description = "Notification topic name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Notification topic description."
  type        = string
  default     = null
  nullable    = true
}

variable "subscriptions" {
  description = "Subscriptions keyed by a stable Terraform name. Email subscriptions require recipient confirmation."
  type = map(object({
    protocol = string
    endpoint = string
  }))
  default  = {}
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
