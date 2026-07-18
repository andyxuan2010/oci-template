variable "compartment_id" {
  description = "Compartment OCID."
  type        = string
}

variable "display_name" {
  description = "Load balancer display name."
  type        = string
}

variable "shape" {
  description = "Load balancer shape."
  type        = string
  default     = "flexible"
}

variable "minimum_bandwidth_in_mbps" {
  description = "Minimum bandwidth for flexible shape."
  type        = number
  default     = 10
}

variable "maximum_bandwidth_in_mbps" {
  description = "Maximum bandwidth for flexible shape."
  type        = number
  default     = 100
}

variable "subnet_ids" {
  description = "Subnet OCIDs for the load balancer."
  type        = list(string)
}

variable "is_private" {
  description = "Whether the load balancer is private."
  type        = bool
  default     = true
}

variable "network_security_group_ids" {
  description = "NSG OCIDs attached to the load balancer."
  type        = list(string)
  default     = []
}

variable "backend_sets" {
  description = "Backend set definitions keyed by backend set name."
  type = map(object({
    policy = optional(string, "ROUND_ROBIN")
    health_checker = object({
      protocol            = string
      port                = number
      url_path            = optional(string)
      return_code         = optional(number)
      retries             = optional(number)
      timeout_in_millis   = optional(number)
      interval_ms         = optional(number)
      response_body_regex = optional(string)
    })
  }))
  default = {}
}

variable "backends" {
  description = "Backend definitions keyed by logical name."
  type = map(object({
    backend_set_name = string
    ip_address       = string
    port             = number
    backup           = optional(bool, false)
    drain            = optional(bool, false)
    offline          = optional(bool, false)
    weight           = optional(number, 1)
  }))
  default = {}
}

variable "listeners" {
  description = "Listener definitions keyed by listener name."
  type = map(object({
    default_backend_set_name = string
    port                     = number
    protocol                 = string
    hostname_names           = optional(list(string), [])
    path_route_set_name      = optional(string)
    rule_set_names           = optional(list(string), [])
    ssl_configuration = optional(object({
      certificate_name        = string
      verify_peer_certificate = optional(bool, false)
    }))
  }))
  default = {}
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
