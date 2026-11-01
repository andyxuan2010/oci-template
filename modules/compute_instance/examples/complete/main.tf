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
  shape                               = "VM.Standard.E4.Flex"
  ocpus                               = null
  memory_in_gbs                       = null
  image_ocid                          = "example-image-ocid"
  subnet_id                           = "ocid1.subnet.oc1..exampleuniqueid"
  nsg_ids                             = []
  assign_public_ip                    = false
  ssh_public_key                      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExampleKeyOnly example@example.com"
  boot_volume_size_in_gbs             = null
  cloud_init                          = null
  freeform_tags                       = {}
  defined_tags                        = {}
  are_legacy_imds_endpoints_disabled  = true
  is_pv_encryption_in_transit_enabled = true
}
