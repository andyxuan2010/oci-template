resource "oci_monitoring_alarm" "this" {
  compartment_id                                = var.compartment_id
  metric_compartment_id                         = var.metric_compartment_id
  display_name                                  = var.display_name
  namespace                                     = var.namespace
  query                                         = var.query
  severity                                      = var.severity
  destinations                                  = var.destinations
  is_enabled                                    = var.is_enabled
  body                                          = var.body
  alarm_summary                                 = var.alarm_summary
  pending_duration                              = var.pending_duration
  repeat_notification_duration                  = var.repeat_notification_duration
  resolution                                    = var.resolution
  resource_group                                = var.resource_group
  metric_compartment_id_in_subtree              = var.metric_compartment_id_in_subtree
  message_format                                = var.message_format
  notification_title                            = var.notification_title
  is_notifications_per_metric_dimension_enabled = var.is_notifications_per_metric_dimension_enabled
  freeform_tags                                 = var.freeform_tags
  defined_tags                                  = var.defined_tags

  dynamic "suppression" {
    for_each = var.suppression == null ? [] : [var.suppression]
    content {
      time_suppress_from  = suppression.value.time_suppress_from
      time_suppress_until = suppression.value.time_suppress_until
      description         = suppression.value.description
    }
  }
}
