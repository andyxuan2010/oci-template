variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Event rule display name."
  type        = string
  nullable    = false
}

variable "condition" {
  description = "OCI event-matching condition as a JSON object."
  type        = string
  validation {
    condition     = can(keys(jsondecode(var.condition)))
    error_message = "condition must be a JSON object."
  }
  nullable = false
}

variable "is_enabled" {
  description = "Enable event routing."
  type        = bool
  default     = true
  nullable    = false
}

variable "actions" {
  description = "Actions keyed by logical name. Each action must have exactly its matching destination."
  type = map(object({
    action_type = string
    is_enabled  = optional(bool, true)
    description = optional(string)
    topic_id    = optional(string)
    function_id = optional(string)
    stream_id   = optional(string)
  }))
  validation {
    condition = length(var.actions) > 0 && alltrue([for a in values(var.actions) :
      (a.action_type == "ONS" && a.topic_id != null && a.function_id == null && a.stream_id == null) ||
      (a.action_type == "FAAS" && a.function_id != null && a.topic_id == null && a.stream_id == null) ||
      (a.action_type == "OSS" && a.stream_id != null && a.topic_id == null && a.function_id == null)
    ])
    error_message = "Supply one or more ONS/topic_id, FAAS/function_id, or OSS/stream_id actions."
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
