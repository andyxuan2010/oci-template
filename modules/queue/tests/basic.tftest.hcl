mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "queue-app-dev"
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = oci_queue_queue.this.dead_letter_queue_delivery_count == 5
    error_message = "Dead-letter delivery must be enabled by default."
  }
  assert {
    condition     = oci_queue_queue.this.timeout_in_seconds == 20
    error_message = "Long polling must be enabled by default."
  }
}

run "customer_managed_encryption" {
  command = plan
  variables {
    custom_encryption_key_id = "ocid1.key.oc1.iad.exampleuniqueid"
  }
  assert {
    condition     = oci_queue_queue.this.custom_encryption_key_id == var.custom_encryption_key_id
    error_message = "Queue must use the supplied encryption key."
  }
}

run "reject_invalid_retention" {
  command = plan
  variables {
    retention_in_seconds = 0
  }
  expect_failures = [var.retention_in_seconds]
}
