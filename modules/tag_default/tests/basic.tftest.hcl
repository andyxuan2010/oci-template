mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id    = "ocid1.compartment.oc1..exampleuniqueid"
    tag_definition_id = "ocid1.tagdefinition.oc1..exampleuniqueid"
    value             = "dev"
    is_required       = true
  }
}
