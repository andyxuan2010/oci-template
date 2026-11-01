mock_provider "oci" {}

variables {
  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
  display_name        = "key-app-dev"
  algorithm           = "AES"
  length              = 32
  protection_mode     = "HSM"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "reject_rotation_without_interval" {
  command = plan
  variables {
    is_auto_rotation_enabled  = true
    rotation_interval_in_days = null
  }
  expect_failures = [oci_kms_key.this]
}

run "valid_rotation" {
  command = plan
  variables {
    is_auto_rotation_enabled  = true
    rotation_interval_in_days = 365
  }
  assert {
    condition     = oci_kms_key.this.is_auto_rotation_enabled
    error_message = "Explicit scheduled rotation must be supported."
  }
}
