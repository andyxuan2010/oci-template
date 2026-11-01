variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Backup policy display name."
  type        = string
  nullable    = false
}

variable "destination_region" {
  description = "Optional supported paired region for backup copies."
  type        = string
  default     = null
  nullable    = true
}

variable "schedules" {
  description = "Backup schedules keyed by logical name."
  type = map(object({
    period            = optional(string, "ONE_DAY")
    backup_type       = optional(string, "INCREMENTAL")
    retention_seconds = optional(number, 604800)
    hour_of_day       = optional(number, 2)
    day_of_week       = optional(string)
    day_of_month      = optional(number)
    month             = optional(string)
    time_zone         = optional(string, "UTC")
  }))
  default = { daily = {} }
  validation {
    condition = length(var.schedules) > 0 && alltrue([for s in values(var.schedules) :
      contains(["ONE_DAY", "ONE_WEEK", "ONE_MONTH", "ONE_YEAR"], s.period) &&
      contains(["FULL", "INCREMENTAL"], s.backup_type) &&
      s.retention_seconds > 0 && floor(s.retention_seconds) == s.retention_seconds &&
      s.hour_of_day >= 0 && s.hour_of_day <= 23 && floor(s.hour_of_day) == s.hour_of_day &&
      contains(["UTC", "REGIONAL_DATA_CENTER_TIME"], s.time_zone)
    ])
    error_message = "Schedules require a supported period, backup type, timezone, positive integer retention, and an hour from 0 to 23."
  }
  nullable = false
}

variable "asset_ids" {
  description = "Boot volume, block volume, or volume group OCIDs keyed by stable logical name."
  type        = map(string)
  default     = {}
  nullable    = false
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
