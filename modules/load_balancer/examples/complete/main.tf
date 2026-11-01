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
  shape                      = "flexible"
  minimum_bandwidth_in_mbps  = 10
  maximum_bandwidth_in_mbps  = 100
  subnet_ids                 = ["ocid1.subnet.oc1..exampleuniqueid"]
  is_private                 = true
  network_security_group_ids = []
  backend_sets               = {}
  backends                   = {}
  listeners                  = {}
  freeform_tags              = {}
  defined_tags               = {}
}
