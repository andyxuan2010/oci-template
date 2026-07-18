# Copy this file per environment and fill in your OCI values.

region       = "ca-montreal-1"
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaats4u3agsrtsqq52et7penbl64hzitb45hsholkx73kcblo2ps7gq"


# Option A: create a child compartment under the tenancy.
create_compartment = true

# Option B: use an existing compartment instead.
# create_compartment = false
# compartment_ocid   = "ocid1.compartment.oc1..replace-me"

# API key authentication.
auth                = "APIKey"
config_file_profile = "DEFAULT"
user_ocid           = "ocid1.user.oc1..aaaaaaaavtdkqhu336wem37crkrfgvnnlvtpq75ow5r32raxkdie4pghchja"
fingerprint         = "f4:08:23:1f:68:a9:71:45:74:3c:d3:96:be:6c:58:83"
private_key_path    = "C:/Users/administrator/.oci/oci_api_key.pem"

# For short-lived local auth, use a CLI security token instead:
# auth                = "SecurityToken"
# config_file_profile = "tf"
# user_ocid           = null
# fingerprint         = null
# private_key_path    = null

workload    = "app"
environment = "dev"

freeform_tags = {
  cost_center = "ccoe"
  owner       = "cloud-platform"
}

vcn_cidr_blocks = ["10.20.0.0/16"]

subnets = {
  app = {
    cidr_block                 = "10.20.1.0/24"
    dns_label                  = "app"
    prohibit_public_ip_on_vnic = true
  }
}

enable_nat_gateway      = false
enable_internet_gateway = false

create_object_storage_bucket = true
create_vault                 = false

# Compute is off by default because image OCIDs vary by region and OS.
create_compute_instance = false
# compute_image_ocid    = "ocid1.image.oc1.iad.replace-me"
# ssh_public_key        = "ssh-rsa replace-me"
