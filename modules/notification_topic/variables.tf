variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "name" {
  description = "Notification topic name."
  type        = string
}

variable "description" {
  description = "Notification topic description."
  type        = string
  default     = null
}

variable "subscriptions" {
  description = "Subscriptions keyed by a stable Terraform name. Email subscriptions require recipient confirmation."
  type = map(object({
    protocol = string
    endpoint = string
  }))
  default = {}
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
