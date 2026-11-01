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
  source  = "../.."
  zone_id = "ocid1.zone.oc1..exampleuniqueid"
  domain  = "example-domain"
  rtype   = "example-rtype"
  records = ["example-records"]
}
