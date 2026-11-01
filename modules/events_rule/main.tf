resource "oci_events_rule" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  condition      = var.condition
  is_enabled     = var.is_enabled
  actions {
    dynamic "action" {
      for_each = var.actions
      content {
        action_type = action.value.action_type
        is_enabled  = action.value.is_enabled
        description = action.value.description
        topic_id    = action.value.topic_id
        function_id = action.value.function_id
        stream_id   = action.value.stream_id
      }
    }
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}
