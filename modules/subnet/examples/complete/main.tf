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
  source                    = "../.."
  compartment_id            = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id                    = "ocid1.vcn.oc1..exampleuniqueid"
  default_route_table_id    = null
  default_security_list_ids = []
  subnets                   = { app = { cidr_block = "10.0.1.0/24" } }
  freeform_tags             = {}
  defined_tags              = {}
}
