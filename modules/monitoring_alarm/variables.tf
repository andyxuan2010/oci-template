variable "compartment_id" {
  description = "Compartment OCID that owns the alarm."
  type        = string
}

variable "metric_compartment_id" {
  description = "Compartment OCID containing the monitored metrics."
  type        = string
}

variable "display_name" {
  description = "Alarm display name."
  type        = string
}

variable "namespace" {
  description = "Monitoring metric namespace, such as oci_computeagent."
  type        = string
}

variable "query" {
  description = "Monitoring Query Language expression."
  type        = string
}

variable "severity" {
  description = "Alarm severity."
  type        = string
  default     = "WARNING"
}

variable "destinations" {
  description = "Notification topic OCIDs."
  type        = list(string)
}

variable "is_enabled" {
  description = "Whether alarm evaluation and notifications are enabled."
  type        = bool
  default     = true
}

variable "body" {
  description = "Notification body."
  type        = string
  default     = null
}

variable "alarm_summary" {
  description = "Alarm summary included in notifications."
  type        = string
  default     = null
}

variable "pending_duration" {
  description = "ISO-8601 duration that the condition must persist before firing."
  type        = string
  default     = "PT5M"
}

variable "repeat_notification_duration" {
  description = "ISO-8601 interval for repeated notifications. Null disables repeats."
  type        = string
  default     = null
}

variable "resolution" {
  description = "Metric query resolution."
  type        = string
  default     = null
}

variable "resource_group" {
  description = "Optional metric resource group."
  type        = string
  default     = null
}

variable "metric_compartment_id_in_subtree" {
  description = "Whether metrics in child compartments are included."
  type        = bool
  default     = false
}

variable "message_format" {
  description = "Alarm message format, such as RAW or PRETTY_JSON."
  type        = string
  default     = null
}

variable "notification_title" {
  description = "Optional notification title."
  type        = string
  default     = null
}

variable "is_notifications_per_metric_dimension_enabled" {
  description = "Send notifications for each metric stream dimension."
  type        = bool
  default     = false
}

variable "suppression" {
  description = "Optional scheduled alarm suppression window."
  type = object({
    time_suppress_from  = string
    time_suppress_until = string
    description         = optional(string)
  })
  default = null
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
