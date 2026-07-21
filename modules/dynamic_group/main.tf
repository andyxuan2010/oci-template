resource "oci_identity_dynamic_group" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  matching_rule  = var.matching_rule
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
