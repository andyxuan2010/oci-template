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
  source                           = "../.."
  compartment_id                   = "ocid1.compartment.oc1..exampleuniqueid"
  display_name                     = "example-display-name"
  retention_in_seconds             = 345600
  visibility_in_seconds            = 30
  timeout_in_seconds               = 20
  dead_letter_queue_delivery_count = 5
  custom_encryption_key_id         = null
  freeform_tags                    = {}
  defined_tags                     = {}
}
