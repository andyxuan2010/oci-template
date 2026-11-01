resource "oci_ons_notification_topic" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_ons_subscription" "this" {
  for_each = var.subscriptions

  compartment_id = var.compartment_id
  topic_id       = oci_ons_notification_topic.this.id
  protocol       = each.value.protocol
  endpoint       = each.value.endpoint
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
