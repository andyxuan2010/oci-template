resource "oci_kms_vault" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  vault_type     = var.vault_type
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
