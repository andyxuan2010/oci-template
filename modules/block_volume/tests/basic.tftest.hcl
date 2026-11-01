mock_provider "oci" {}

variables {
  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name        = "vol-app-dev-001"
  size_in_gbs         = 100
  vpus_per_gb         = 10
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "encrypted_attachment" {
  command = plan
  variables {
    attach_to_instance_id = "ocid1.instance.oc1.iad.exampleuniqueid"
  }
  assert {
    condition     = oci_core_volume_attachment.this[0].is_pv_encryption_in_transit_enabled
    error_message = "Paravirtualized attachment transport must be encrypted."
  }
}

run "reject_small_volume" {
  command = plan
  variables {
    size_in_gbs = 1
  }
  expect_failures = [var.size_in_gbs]
}
