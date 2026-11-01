resource "oci_apigateway_gateway" "this" {
  compartment_id             = var.compartment_id
  display_name               = var.display_name
  subnet_id                  = var.subnet_id
  endpoint_type              = var.endpoint_type
  network_security_group_ids = var.network_security_group_ids
  freeform_tags              = var.freeform_tags
  defined_tags               = var.defined_tags
}

resource "oci_apigateway_deployment" "this" {
  for_each       = var.deployments
  compartment_id = var.compartment_id
  gateway_id     = oci_apigateway_gateway.this.id
  display_name   = each.key
  path_prefix    = each.value.path_prefix
  specification {
    dynamic "routes" {
      for_each = each.value.routes
      content {
        path    = routes.value.path
        methods = routes.value.methods
        backend {
          type                   = "HTTP_BACKEND"
          url                    = routes.value.url
          is_ssl_verify_disabled = false
        }
      }
    }
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}
