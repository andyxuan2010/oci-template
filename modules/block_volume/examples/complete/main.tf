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
  source                              = "../.."
  compartment_id                      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain                 = "example-availability-domain"
  display_name                        = "example-display-name"
  size_in_gbs                         = 50
  vpus_per_gb                         = 10
  backup_policy_id                    = null
  kms_key_id                          = null
  attach_to_instance_id               = null
  attachment_type                     = "paravirtualized"
  is_read_only                        = false
  is_shareable                        = false
  freeform_tags                       = {}
  defined_tags                        = {}
  is_pv_encryption_in_transit_enabled = true
}
