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
  source                = "../.."
  compartment_id        = "ocid1.compartment.oc1..exampleuniqueid"
  namespace             = "example-namespace"
  name                  = "example-name"
  access_type           = "NoPublicAccess"
  storage_tier          = "Standard"
  versioning            = "Enabled"
  freeform_tags         = {}
  defined_tags          = {}
  kms_key_id            = null
  object_events_enabled = false
}
