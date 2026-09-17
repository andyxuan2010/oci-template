mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
    management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
    display_name        = "key-app-dev"
    algorithm           = "AES"
    length              = 32
    protection_mode     = "HSM"
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
