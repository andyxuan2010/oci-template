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
  name           = "example-name"
  description    = "example-description"
  is_retired     = false
  tags           = {}
  freeform_tags  = {}
  defined_tags   = {}
}
