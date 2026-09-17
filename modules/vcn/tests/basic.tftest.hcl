mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    display_name   = "vcn-app-dev"
    cidr_blocks    = ["10.20.0.0/16"]
    dns_label      = "appdev"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
