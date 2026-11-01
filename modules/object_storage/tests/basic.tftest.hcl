mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  namespace      = "exampletenancy"
  name           = "bucket-app-dev"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "private_versioned_defaults" {
  command = plan
  assert {
    condition     = oci_objectstorage_bucket.this.access_type == "NoPublicAccess"
    error_message = "Buckets must default to private access."
  }
  assert {
    condition     = oci_objectstorage_bucket.this.versioning == "Enabled"
    error_message = "Bucket versioning must default to enabled."
  }
}

run "customer_key_and_events" {
  command = plan
  variables {
    kms_key_id            = "ocid1.key.oc1.iad.exampleuniqueid"
    object_events_enabled = true
  }
  assert {
    condition     = oci_objectstorage_bucket.this.kms_key_id == var.kms_key_id && oci_objectstorage_bucket.this.object_events_enabled
    error_message = "Bucket encryption key and event emission must be wired."
  }
}

run "reject_invalid_access" {
  command = plan
  variables {
    access_type = "Public"
  }
  expect_failures = [var.access_type]
}
