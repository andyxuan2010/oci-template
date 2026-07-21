mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
    name           = "quota-platform-dev"
    description    = "Limit development resources"
    statements = [
      "zero compute-core quotas in compartment platform-dev"
    ]
  }
}
