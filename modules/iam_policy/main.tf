resource "oci_identity_policy" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  statements     = var.statements
  version_date   = var.version_date
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
