output "id" {
  description = "Tag namespace OCID."
  value       = oci_identity_tag_namespace.this.id
}

output "tag_ids" {
  description = "Tag definition OCIDs keyed by tag name."
  value       = { for name, tag in oci_identity_tag.this : name => tag.id }
}

output "tag_names" {
  description = "Tag definition names keyed by tag name."
  value       = { for name, tag in oci_identity_tag.this : name => tag.name }
}
