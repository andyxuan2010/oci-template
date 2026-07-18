mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    display_name   = "vault-app-dev"
    vault_type     = "DEFAULT"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
