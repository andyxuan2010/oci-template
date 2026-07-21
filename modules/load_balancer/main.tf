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
}

resource "oci_load_balancer_backend_set" "this" {
  for_each = var.backend_sets

  load_balancer_id = oci_load_balancer_load_balancer.this.id
  name             = each.key
  policy           = try(each.value.policy, "ROUND_ROBIN")

  health_checker {
    protocol            = each.value.health_checker.protocol
    port                = each.value.health_checker.port
    url_path            = try(each.value.health_checker.url_path, null)
    return_code         = try(each.value.health_checker.return_code, null)
    retries             = try(each.value.health_checker.retries, null)
    timeout_in_millis   = try(each.value.health_checker.timeout_in_millis, null)
    interval_ms         = try(each.value.health_checker.interval_ms, null)
    response_body_regex = try(each.value.health_checker.response_body_regex, null)
  }
}

resource "oci_load_balancer_backend" "this" {
  for_each = var.backends

  load_balancer_id = oci_load_balancer_load_balancer.this.id
  backendset_name  = each.value.backend_set_name
  ip_address       = each.value.ip_address
  port             = each.value.port
  backup           = try(each.value.backup, false)
  drain            = try(each.value.drain, false)
  offline          = try(each.value.offline, false)
  weight           = try(each.value.weight, 1)

  depends_on = [oci_load_balancer_backend_set.this]
}

resource "oci_load_balancer_listener" "this" {
  for_each = var.listeners

  load_balancer_id         = oci_load_balancer_load_balancer.this.id
  name                     = each.key
  default_backend_set_name = each.value.default_backend_set_name
  port                     = each.value.port
  protocol                 = each.value.protocol
  hostname_names           = try(each.value.hostname_names, [])
  path_route_set_name      = try(each.value.path_route_set_name, null)
  rule_set_names           = try(each.value.rule_set_names, [])

  dynamic "ssl_configuration" {
    for_each = try(each.value.ssl_configuration, null) == null ? [] : [each.value.ssl_configuration]
    content {
      certificate_name        = ssl_configuration.value.certificate_name
      verify_peer_certificate = try(ssl_configuration.value.verify_peer_certificate, false)
    }
  }

  depends_on = [oci_load_balancer_backend_set.this]
}
