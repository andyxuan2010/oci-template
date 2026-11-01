variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
  nullable    = false
}

variable "display_name" {
  description = "Gateway display name."
  type        = string
  nullable    = false
}

variable "subnet_id" {
  description = "Gateway subnet OCID."
  type        = string
  nullable    = false
}

variable "endpoint_type" {
  description = "PRIVATE or PUBLIC gateway endpoint."
  type        = string
  default     = "PRIVATE"
  validation {
    condition     = contains(["PRIVATE", "PUBLIC"], var.endpoint_type)
    error_message = "endpoint_type must be PRIVATE or PUBLIC."
  }
  nullable = false
}

variable "network_security_group_ids" {
  description = "Gateway NSG OCIDs."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "deployments" {
  description = "HTTP backend deployments keyed by stable logical name."
  type = map(object({
    path_prefix = string
    routes = map(object({
      path    = string
      methods = optional(list(string), ["GET"])
      url     = string
    }))
  }))
  default = {}
  validation {
    condition = alltrue([for d in values(var.deployments) :
      startswith(d.path_prefix, "/") && length(d.routes) > 0 &&
      alltrue([for r in values(d.routes) : startswith(r.path, "/") && startswith(r.url, "https://") && length(r.methods) > 0])
    ])
    error_message = "Deployments require a slash-prefixed path, nonempty routes, methods, and HTTPS backend URLs."
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
