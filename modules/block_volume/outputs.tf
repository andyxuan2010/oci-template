output "id" {
  description = "Block volume OCID."
  value       = oci_core_volume.this.id
}

output "display_name" {
  description = "Block volume display name."
  value       = oci_core_volume.this.display_name
}

output "attachment_id" {
  description = "Volume attachment OCID when enabled."
  value       = try(oci_core_volume_attachment.this[0].id, null)
}
