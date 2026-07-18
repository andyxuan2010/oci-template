data "oci_identity_availability_domains" "this" {
  compartment_id = var.tenancy_ocid
}

data "oci_objectstorage_namespace" "this" {
  compartment_id = var.tenancy_ocid
}
