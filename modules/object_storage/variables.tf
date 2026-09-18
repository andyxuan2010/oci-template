variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "namespace" {
  description = "Object Storage namespace."
  type        = string
}

variable "name" {
  description = "Bucket name."
  type        = string
}

variable "access_type" {
  description = "Bucket access type."
  type        = string
  default     = "NoPublicAccess"
}

variable "storage_tier" {
  description = "Bucket storage tier."
  type        = string
  default     = "Standard"
}

variable "versioning" {
  description = "Bucket object versioning: Enabled or Disabled."
  type        = string
  default     = "Enabled"
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
