variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "name" {
  description = "DNS zone name."
  type        = string
  nullable    = false
}

variable "zone_type" {
  description = "DNS zone type, such as PRIMARY."
  type        = string
  default     = "PRIMARY"
  nullable    = false
}

variable "scope" {
  description = "DNS scope. Use GLOBAL for public DNS or PRIVATE for private DNS."
  type        = string
  default     = "PRIVATE"
  validation {
    condition     = contains(["PRIVATE", "GLOBAL"], var.scope)
    error_message = "DNS scope must be PRIVATE or GLOBAL."
  }
  nullable = false
}

variable "view_id" {
  description = "Private DNS view OCID when scope is PRIVATE."
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
