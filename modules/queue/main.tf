resource "oci_queue_queue" "this" {
  compartment_id                   = var.compartment_id
  display_name                     = var.display_name
  retention_in_seconds             = var.retention_in_seconds
  visibility_in_seconds            = var.visibility_in_seconds
  timeout_in_seconds               = var.timeout_in_seconds
  dead_letter_queue_delivery_count = var.dead_letter_queue_delivery_count
  custom_encryption_key_id         = var.custom_encryption_key_id
  freeform_tags                    = var.freeform_tags
  defined_tags                     = var.defined_tags
}
