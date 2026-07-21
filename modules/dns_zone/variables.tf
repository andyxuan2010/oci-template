variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "name" {
  description = "DNS zone name."
  type        = string
}

variable "zone_type" {
  description = "DNS zone type, such as PRIMARY."
  type        = string
  default     = "PRIMARY"
}

variable "scope" {
  description = "DNS scope. Use GLOBAL for public DNS or PRIVATE for private DNS."
  type        = string
  default     = "GLOBAL"
}

variable "view_id" {
  description = "Private DNS view OCID when scope is PRIVATE."
  type        = string
  default     = null
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
