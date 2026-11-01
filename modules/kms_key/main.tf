resource "oci_kms_key" "this" {
  compartment_id           = var.compartment_id
  management_endpoint      = var.management_endpoint
  display_name             = var.display_name
  protection_mode          = var.protection_mode
  is_auto_rotation_enabled = var.is_auto_rotation_enabled
  freeform_tags            = var.freeform_tags
  defined_tags             = var.defined_tags

  key_shape {
    algorithm = var.algorithm
    length    = var.length
    curve_id  = var.curve_id
  }

  dynamic "auto_key_rotation_details" {
    for_each = var.is_auto_rotation_enabled ? [1] : []
    content {
      rotation_interval_in_days = var.rotation_interval_in_days
      time_of_schedule_start    = var.time_of_schedule_start
    }
  }

  lifecycle {
    precondition {
      condition     = !var.is_auto_rotation_enabled || try(var.rotation_interval_in_days >= 60 && var.rotation_interval_in_days <= 365 && floor(var.rotation_interval_in_days) == var.rotation_interval_in_days, false)
      error_message = "Automatic rotation requires an integer interval from 60 to 365 days."
    }
  }

}
