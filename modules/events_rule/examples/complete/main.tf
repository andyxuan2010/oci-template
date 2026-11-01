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
  display_name   = "example-display-name"
  condition      = "{\"eventType\": [\"com.oraclecloud.objectstorage.createobject\"]}"
  is_enabled     = true
  actions        = { notify = { action_type = "ONS", topic_id = "ocid1.onstopic.oc1..exampleuniqueid" } }
  freeform_tags  = {}
  defined_tags   = {}
}
