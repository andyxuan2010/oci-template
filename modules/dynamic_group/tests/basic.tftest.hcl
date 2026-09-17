mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
    name           = "dg-app-dev"
    description    = "Dynamic group for app dev instances"
    matching_rule  = "ALL {instance.compartment.id = 'ocid1.compartment.oc1..exampleuniqueid'}"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
