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
  management_endpoint       = "example-management-endpoint"
  display_name              = "example-display-name"
  algorithm                 = "AES"
  length                    = 32
  curve_id                  = null
  protection_mode           = "HSM"
  is_auto_rotation_enabled  = false
  rotation_interval_in_days = null
  time_of_schedule_start    = null
  freeform_tags             = {}
  defined_tags              = {}
}
