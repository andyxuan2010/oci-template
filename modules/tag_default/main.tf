resource "oci_identity_tag_default" "this" {
  compartment_id    = var.compartment_id
  tag_definition_id = var.tag_definition_id
  value             = var.value
  is_required       = var.is_required
}
