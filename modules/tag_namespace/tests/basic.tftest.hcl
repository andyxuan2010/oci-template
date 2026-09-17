mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
    name           = "Governance"
    description    = "Landing-zone governance tags"
    tags = {
      Environment = {
        description      = "Deployment environment"
        is_cost_tracking = true
        validator = {
          validator_type = "ENUM"
          values         = ["dev", "sandbox", "prod"]
        }
      }
    }
  }
}
