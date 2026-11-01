mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "adb-app-dev"
  db_name        = "APPDEV"
  admin_password = "TestOnlyPassword42!"
  subnet_id      = "ocid1.subnet.oc1.iad.exampleuniqueid"
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = oci_database_autonomous_database.this.is_mtls_connection_required
    error_message = "Mutual TLS must be required."
  }
  assert {
    condition     = oci_database_autonomous_database.this.subnet_id == var.subnet_id
    error_message = "Database must use the private endpoint subnet."
  }
  assert {
    condition     = !oci_database_autonomous_database.this.is_auto_scaling_enabled
    error_message = "Autoscaling must require explicit opt-in."
  }
}

run "explicit_capacity" {
  command = plan
  variables {
    compute_count           = 4
    is_auto_scaling_enabled = true
  }
  assert {
    condition     = oci_database_autonomous_database.this.compute_count == 4 && oci_database_autonomous_database.this.is_auto_scaling_enabled
    error_message = "Explicit database capacity must be respected."
  }
}

run "reject_invalid_name" {
  command = plan
  variables {
    db_name = "invalid-name"
  }
  expect_failures = [var.db_name]
}
