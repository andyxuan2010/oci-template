mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    parent_compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
    name                  = "cmp-app-dev"
    description           = "Compartment for app dev resources"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
