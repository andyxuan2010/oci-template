mock_provider "oci" {}

run "basic_plan" {
  command = plan

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
}
