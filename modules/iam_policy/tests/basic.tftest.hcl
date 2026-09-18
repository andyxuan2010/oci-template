mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    name           = "policy-app-dev"
    description    = "Allow app operators to inspect instances"
    statements     = ["Allow group app-operators to inspect instances in compartment cmp-app-dev"]
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
