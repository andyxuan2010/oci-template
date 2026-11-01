variable "compartment_id" {
  description = "OCID of the tenancy or compartment that owns the budget resource."
  type        = string
  nullable    = false
}

variable "amount" {
  description = "Budget amount in the tenancy currency."
  type        = number

  validation {
    condition     = var.amount > 0
    error_message = "amount must be greater than zero."
  }
  nullable = false
}

variable "reset_period" {
  description = "Budget reset period."
  type        = string
  default     = "MONTHLY"
  nullable    = false
}

variable "display_name" {
  description = "Budget display name."
  type        = string
  nullable    = false
}

variable "description" {
  description = "Budget description."
  type        = string
  default     = null
  nullable    = true
}

variable "target_type" {
  description = "Budget target type, normally COMPARTMENT or TAG."
  type        = string
  default     = "COMPARTMENT"
  nullable    = false
}

variable "targets" {
  description = "Target compartment OCIDs or tag values tracked by the budget."
  type        = list(string)

  validation {
    condition     = length(var.targets) > 0
    error_message = "targets must contain at least one compartment OCID or tag target."
  }
  nullable = false
}

variable "processing_period_type" {
  description = "Budget processing period type."
  type        = string
  default     = null
  nullable    = true
}

variable "start_date" {
  description = "Optional RFC3339 budget start date."
  type        = string
  default     = null
  nullable    = true
}

variable "end_date" {
  description = "Optional RFC3339 budget end date."
  type        = string
  default     = null
  nullable    = true
}

variable "alert_rules" {
  description = "Budget alert rules keyed by a stable Terraform name. Recipients is a comma-separated email list."
  type = map(object({
    threshold      = number
    recipients     = string
    threshold_type = optional(string, "PERCENTAGE")
    type           = optional(string, "ACTUAL")
    display_name   = optional(string)
    description    = optional(string)
    message        = optional(string)
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
