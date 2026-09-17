resource "oci_limits_quota" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  statements     = var.statements
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
