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
  source                        = "../.."
  compartment_id                = "ocid1.compartment.oc1..exampleuniqueid"
  target_subnet_id              = "ocid1.subnet.oc1..exampleuniqueid"
  bastion_type                  = "STANDARD"
  name                          = "example-name"
  client_cidr_block_allow_list  = []
  max_session_ttl_in_seconds    = 10800
  dns_proxy_status              = null
  static_jump_host_ip_addresses = null
  freeform_tags                 = {}
  defined_tags                  = {}
}
