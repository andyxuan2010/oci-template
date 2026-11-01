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
  availability_domain       = "example-availability-domain"
  file_system_display_name  = "example-file-system-display-name"
  mount_target_display_name = "example-mount-target-display-name"
  subnet_id                 = "ocid1.subnet.oc1..exampleuniqueid"
  hostname_label            = null
  nsg_ids                   = []
  kms_key_id                = null
  export_path               = "/export"
  export_options            = [{ source = "10.0.0.0/16" }]
  freeform_tags             = {}
  defined_tags              = {}
}
