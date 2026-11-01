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
  source                   = "../.."
  compartment_id           = "ocid1.compartment.oc1..exampleuniqueid"
  display_name             = "example-display-name"
  db_name                  = "exampledb"
  admin_password           = "example-admin-password"
  subnet_id                = "ocid1.subnet.oc1..exampleuniqueid"
  nsg_ids                  = []
  compute_count            = 2
  data_storage_size_in_tbs = 1
  is_auto_scaling_enabled  = false
  license_model            = "LICENSE_INCLUDED"
  freeform_tags            = {}
  defined_tags             = {}
}
