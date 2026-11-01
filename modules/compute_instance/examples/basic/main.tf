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
  source              = "../.."
  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "example-availability-domain"
  display_name        = "example-display-name"
  shape               = "VM.Standard.E4.Flex"
  image_ocid          = "example-image-ocid"
  subnet_id           = "ocid1.subnet.oc1..exampleuniqueid"
  ssh_public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIExampleKeyOnly example@example.com"
}
