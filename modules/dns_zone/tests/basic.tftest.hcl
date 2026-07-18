mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    name           = "example.internal"
    zone_type      = "PRIMARY"
    scope          = "GLOBAL"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
