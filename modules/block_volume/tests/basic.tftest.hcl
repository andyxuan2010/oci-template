mock_provider "oci" {}

run "basic_plan" {
  command = plan

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
}
