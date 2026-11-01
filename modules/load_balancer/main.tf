resource "oci_load_balancer_load_balancer" "this" {
  compartment_id             = var.compartment_id
  display_name               = var.display_name
  shape                      = var.shape
  subnet_ids                 = var.subnet_ids
  is_private                 = var.is_private
  network_security_group_ids = var.network_security_group_ids
  freeform_tags              = var.freeform_tags
  defined_tags               = var.defined_tags

  dynamic "shape_details" {
    for_each = var.shape == "flexible" ? [1] : []
    content {
      minimum_bandwidth_in_mbps = var.minimum_bandwidth_in_mbps
      maximum_bandwidth_in_mbps = var.maximum_bandwidth_in_mbps
    }
  }

  lifecycle {
    precondition {
      condition     = var.minimum_bandwidth_in_mbps > 0 && var.maximum_bandwidth_in_mbps >= var.minimum_bandwidth_in_mbps
      error_message = "Maximum bandwidth must be at least the positive minimum bandwidth."
    }
  }

}

resource "oci_load_balancer_backend_set" "this" {
  for_each = var.backend_sets

  load_balancer_id = oci_load_balancer_load_balancer.this.id
  name             = each.key
  policy           = each.value.policy

  health_checker {
    protocol            = each.value.health_checker.protocol
    port                = each.value.health_checker.port
    url_path            = each.value.health_checker.url_path
    return_code         = each.value.health_checker.return_code
    retries             = each.value.health_checker.retries
    timeout_in_millis   = each.value.health_checker.timeout_in_millis
    interval_ms         = each.value.health_checker.interval_ms
    response_body_regex = each.value.health_checker.response_body_regex
  }
}

resource "oci_load_balancer_backend" "this" {
  for_each = var.backends

  load_balancer_id = oci_load_balancer_load_balancer.this.id
  backendset_name  = each.value.backend_set_name
  ip_address       = each.value.ip_address
  port             = each.value.port
  backup           = each.value.backup
  drain            = each.value.drain
  offline          = each.value.offline
  weight           = each.value.weight

  depends_on = [oci_load_balancer_backend_set.this]

  lifecycle {
    precondition {
      condition     = contains(keys(var.backend_sets), each.value.backend_set_name)
      error_message = "Backends must reference a backend set managed by this module."
    }
  }

}

resource "oci_load_balancer_listener" "this" {
  for_each = var.listeners

  load_balancer_id         = oci_load_balancer_load_balancer.this.id
  name                     = each.key
  default_backend_set_name = each.value.default_backend_set_name
  port                     = each.value.port
  protocol                 = each.value.protocol
  hostname_names           = each.value.hostname_names
  path_route_set_name      = each.value.path_route_set_name
  rule_set_names           = each.value.rule_set_names

  dynamic "ssl_configuration" {
    for_each = each.value.ssl_configuration == null ? [] : [each.value.ssl_configuration]
    content {
      certificate_name        = ssl_configuration.value.certificate_name
      certificate_ids         = ssl_configuration.value.certificate_ids
      protocols               = ssl_configuration.value.protocols
      verify_peer_certificate = ssl_configuration.value.verify_peer_certificate
    }
  }

  depends_on = [oci_load_balancer_backend_set.this]

  lifecycle {
    precondition {
      condition     = contains(keys(var.backend_sets), each.value.default_backend_set_name)
      error_message = "Listeners must reference a backend set managed by this module."
    }
    precondition {
      condition     = each.value.ssl_configuration == null ? true : (each.value.ssl_configuration.certificate_name != null || length(each.value.ssl_configuration.certificate_ids) > 0) && alltrue([for protocol in each.value.ssl_configuration.protocols : contains(["TLSv1.2", "TLSv1.3"], protocol)]) && length(each.value.ssl_configuration.protocols) > 0
      error_message = "TLS listeners require a certificate and only TLSv1.2/TLSv1.3 protocols."
    }
  }

}
