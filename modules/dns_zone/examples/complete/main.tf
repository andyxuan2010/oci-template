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
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  view_id        = null
  freeform_tags  = {}
  defined_tags   = {}
}
