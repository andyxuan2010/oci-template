resource "oci_core_volume_backup_policy" "this" {
  compartment_id     = var.compartment_id
  display_name       = var.display_name
  destination_region = var.destination_region
  dynamic "schedules" {
    for_each = var.schedules
    content {
      period            = schedules.value.period
      backup_type       = schedules.value.backup_type
      retention_seconds = schedules.value.retention_seconds
      hour_of_day       = schedules.value.hour_of_day
      day_of_week       = schedules.value.day_of_week
      day_of_month      = schedules.value.day_of_month
      month             = schedules.value.month
      time_zone         = schedules.value.time_zone
      offset_type       = "STRUCTURED"
    }
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_core_volume_backup_policy_assignment" "this" {
  for_each  = var.asset_ids
  asset_id  = each.value
  policy_id = oci_core_volume_backup_policy.this.id
}
