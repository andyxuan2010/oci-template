output "id" {
  description = "Tag default OCID."
  value       = oci_identity_tag_default.this.id
}

output "tag_definition_name" {
  description = "Name of the tag definition used by the default."
  value       = oci_identity_tag_default.this.tag_definition_name
}
