variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Queue display name."
  type        = string
  nullable    = false
}

variable "retention_in_seconds" {
  description = "Message retention, from 10 to 604800 seconds."
  type        = number
  default     = 345600
  validation {
    condition     = var.retention_in_seconds >= 10 && var.retention_in_seconds <= 604800 && floor(var.retention_in_seconds) == var.retention_in_seconds
    error_message = "Retention must be an integer from 10 to 604800 seconds."
  }
  nullable = false
}

variable "visibility_in_seconds" {
  description = "Visibility timeout, from 1 to 43200 seconds."
  type        = number
  default     = 30
  validation {
    condition     = var.visibility_in_seconds >= 1 && var.visibility_in_seconds <= 43200 && floor(var.visibility_in_seconds) == var.visibility_in_seconds
    error_message = "Visibility must be an integer from 1 to 43200 seconds."
  }
  nullable = false
}

variable "timeout_in_seconds" {
  description = "Long-poll timeout, from 0 to 30 seconds."
  type        = number
  default     = 20
  validation {
    condition     = var.timeout_in_seconds >= 0 && var.timeout_in_seconds <= 30 && floor(var.timeout_in_seconds) == var.timeout_in_seconds
    error_message = "Polling timeout must be an integer from 0 to 30 seconds."
  }
  nullable = false
}

variable "dead_letter_queue_delivery_count" {
  description = "Delivery attempts before moving to the built-in DLQ; zero disables it."
  type        = number
  default     = 5
  validation {
    condition     = var.dead_letter_queue_delivery_count >= 0 && var.dead_letter_queue_delivery_count <= 20 && floor(var.dead_letter_queue_delivery_count) == var.dead_letter_queue_delivery_count
    error_message = "DLQ delivery count must be an integer from 0 to 20."
  }
  nullable = false
}

variable "custom_encryption_key_id" {
  description = "Optional symmetric KMS key OCID; otherwise service-managed encryption."
  type        = string
  default     = null
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
