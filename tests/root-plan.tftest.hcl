mock_provider "oci" {
  mock_data "oci_identity_availability_domains" {
    defaults = { availability_domains = [{ name = "example:US-ASHBURN-AD-1" }] }
  }
  mock_data "oci_objectstorage_namespace" {
    defaults = { namespace = "exampletenancy" }
  }
}

variables {
  region       = "us-ashburn-1"
  tenancy_ocid = "ocid1.tenancy.oc1..exampleuniqueid"
}

override_module {
  target  = module.security_list
  outputs = { id = "ocid1.securitylist.oc1.iad.lockeddownexample" }
}

run "private_baseline" {
  command = plan
  assert {
    condition     = length(module.subnet.security_list_ids["app"]) == 1 && contains(module.subnet.security_list_ids["app"], "ocid1.securitylist.oc1.iad.lockeddownexample")
    error_message = "Root subnets must use the managed empty security list instead of the OCI default."
  }
  assert {
    condition     = output.compute_instance_id == null && output.vault_id == null
    error_message = "Compute and Vault must remain opt-in."
  }
}

run "reject_compute_without_image" {
  command = plan
  variables { create_compute_instance = true }
  expect_failures = [var.compute_image_ocid, var.ssh_public_key]
}

run "reject_missing_compartment" {
  command = plan
  variables { create_compartment = false }
  expect_failures = [var.compartment_ocid]
}
