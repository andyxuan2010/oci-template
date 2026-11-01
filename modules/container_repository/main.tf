resource "oci_artifacts_container_repository" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  is_public      = var.is_public
  is_immutable   = var.is_immutable
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
