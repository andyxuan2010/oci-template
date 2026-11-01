terraform {
  required_version = ">= 1.7.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 8.23.0, < 9.0.0"
    }
  }
}

provider "oci" {}

module "example" {
  source         = "../.."
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vault_id       = "ocid1.vault.oc1..exampleuniqueid"
  key_id         = "ocid1.key.oc1..exampleuniqueid"
  secret_name    = "example-secret-name"
  secret_content = "example-secret-content"
}
