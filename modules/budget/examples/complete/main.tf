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
  source                 = "../.."
  compartment_id         = "ocid1.compartment.oc1..exampleuniqueid"
  amount                 = 1
  reset_period           = "MONTHLY"
  display_name           = "example-display-name"
  description            = null
  target_type            = "COMPARTMENT"
  targets                = ["ocid1.targets.oc1..exampleuniqueid"]
  processing_period_type = null
  start_date             = null
  end_date               = null
  alert_rules            = {}
  freeform_tags          = {}
  defined_tags           = {}
}
