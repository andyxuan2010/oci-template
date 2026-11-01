mock_provider "oci" {}

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

run "basic_plan" {
  command = plan


}

run "reject_invalid_network" {
  command = plan
  variables {
    cidr_blocks = ["not-a-cidr"]
  }
  expect_failures = [var.cidr_blocks]
}
