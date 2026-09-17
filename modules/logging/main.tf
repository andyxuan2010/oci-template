resource "oci_logging_log_group" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  description    = var.description
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_logging_log" "this" {
  for_each = var.logs

  log_group_id       = oci_logging_log_group.this.id
  display_name       = each.value.display_name
  log_type           = each.value.log_type
  is_enabled         = each.value.is_enabled
  retention_duration = each.value.retention_duration
  freeform_tags      = var.freeform_tags
  defined_tags       = var.defined_tags

  dynamic "configuration" {
    for_each = each.value.configuration == null ? [] : [each.value.configuration]
    content {
      compartment_id = coalesce(configuration.value.compartment_id, var.compartment_id)

      source {
        category    = configuration.value.category
        resource    = configuration.value.resource
        service     = configuration.value.service
        source_type = configuration.value.source_type
        parameters  = configuration.value.parameters
      }
    }
  }
}
