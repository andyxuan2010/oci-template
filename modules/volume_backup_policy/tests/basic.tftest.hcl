mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "backup-app-dev"
  asset_ids      = { data = "ocid1.volume.oc1.iad.exampleuniqueid" }
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = one(oci_core_volume_backup_policy.this.schedules).retention_seconds == 604800
    error_message = "Daily backups must retain seven days by default."
  }
  assert {
    condition     = oci_core_volume_backup_policy_assignment.this["data"].asset_id == var.asset_ids["data"]
    error_message = "Asset assignment must use the supplied volume."
  }
}

run "policy_without_assignments" {
  command = plan
  variables {
    asset_ids = {}
  }
  assert {
    condition     = length(oci_core_volume_backup_policy_assignment.this) == 0
    error_message = "A policy can be created before assigning volumes."
  }
}

run "reject_empty_schedules" {
  command = plan
  variables {
    schedules = {}
  }
  expect_failures = [var.schedules]
}
