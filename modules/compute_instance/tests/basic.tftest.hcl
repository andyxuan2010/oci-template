mock_provider "oci" {}

variables {
  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name        = "vm-app-dev-001"
  shape               = "VM.Standard.E5.Flex"
  ocpus               = 1
  memory_in_gbs       = 8
  image_ocid          = "ocid1.image.oc1.iad.exampleuniqueid"
  subnet_id           = "ocid1.subnet.oc1.iad.exampleuniqueid"
  nsg_ids             = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDexample user@example"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "secure_metadata_and_transport" {
  command = plan
  assert {
    condition     = oci_core_instance.this.instance_options[0].are_legacy_imds_endpoints_disabled
    error_message = "Legacy metadata endpoints must be disabled."
  }
  assert {
    condition     = oci_core_instance.this.is_pv_encryption_in_transit_enabled
    error_message = "Boot volume transport must be encrypted."
  }
  assert {
    condition     = !oci_core_instance.this.create_vnic_details[0].assign_public_ip
    error_message = "Compute must remain private by default."
  }
}

run "reject_private_key" {
  command = plan
  variables {
    ssh_public_key = "-----BEGIN PRIVATE KEY-----"
  }
  expect_failures = [var.ssh_public_key]
}
