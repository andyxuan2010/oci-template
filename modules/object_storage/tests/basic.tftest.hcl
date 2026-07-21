mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    namespace      = "exampletenancy"
    name           = "bucket-app-dev"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
