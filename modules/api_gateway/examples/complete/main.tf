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
  source                     = "../.."
  compartment_id             = "ocid1.compartment.oc1..exampleuniqueid"
  display_name               = "example-display-name"
  subnet_id                  = "ocid1.subnet.oc1..exampleuniqueid"
  endpoint_type              = "PRIVATE"
  network_security_group_ids = []
  deployments                = {}
  freeform_tags              = {}
  defined_tags               = {}
}
