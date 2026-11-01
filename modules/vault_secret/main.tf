resource "oci_vault_secret" "this" {
  compartment_id = var.compartment_id
  vault_id       = var.vault_id
  key_id         = var.key_id
  secret_name    = var.secret_name
  description    = var.description
  secret_content {
    content_type = "BASE64"
    content      = base64encode(var.secret_content)
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}
