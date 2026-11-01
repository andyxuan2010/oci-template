variable "zone_id" {
  description = "DNS zone OCID; prefer an OCID over a zone name."
  type        = string
  nullable    = false
}

variable "domain" {
  description = "Fully qualified record name."
  type        = string
  nullable    = false
}

variable "rtype" {
  description = "DNS record type, for example A or CNAME."
  type        = string
  nullable    = false
}

variable "scope" {
  description = "DNS zone lookup scope; must match the existing zone."
  type        = string
  default     = "PRIVATE"
  validation {
    condition     = contains(["PRIVATE", "GLOBAL"], var.scope)
    error_message = "scope must be PRIVATE or GLOBAL."
  }
  nullable = false
}

variable "ttl" {
  description = "TTL in whole seconds."
  type        = number
  default     = 300
  validation {
    condition     = var.ttl >= 30 && floor(var.ttl) == var.ttl
    error_message = "TTL must be an integer of at least 30 seconds."
  }
  nullable = false
}

variable "records" {
  description = "RDATA values in DNS presentation format."
  type        = list(string)
  validation {
    condition     = length(var.records) > 0
    error_message = "At least one record is required."
  }
  nullable = false
}
