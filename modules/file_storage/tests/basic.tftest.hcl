mock_provider "oci" {}

variables {
  compartment_id            = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain       = "Uocm:US-ASHBURN-AD-1"
  file_system_display_name  = "fss-app-dev"
  mount_target_display_name = "mt-app-dev"
  subnet_id                 = "ocid1.subnet.oc1.iad.exampleuniqueid"
  hostname_label            = "fssappdev"
  nsg_ids                   = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  export_path               = "/appdev"
  export_options = [
    {
      source = "10.20.0.0/16"
      access = "READ_WRITE"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "restricted_export_defaults" {
  command = plan
  assert {
    condition     = one(oci_file_storage_export.this.export_options).identity_squash == "ROOT"
    error_message = "NFS must squash root by default."
  }
  assert {
    condition     = one(oci_file_storage_export.this.export_options).require_privileged_source_port
    error_message = "NFS must require privileged client ports by default."
  }
  assert {
    condition     = !one(oci_file_storage_export.this.export_options).is_anonymous_access_allowed
    error_message = "NFS anonymous access must be disabled."
  }
}

run "reject_implicit_export" {
  command = plan
  variables {
    export_options = []
  }
  expect_failures = [var.export_options]
}

run "reject_world_export" {
  command = plan
  variables {
    export_options = [{ source = "0.0.0.0/0" }]
  }
  expect_failures = [var.export_options]
}
