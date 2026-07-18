output "id" {
  description = "KMS key OCID."
  value       = oci_kms_key.this.id
}

output "display_name" {
  description = "KMS key display name."
  value       = oci_kms_key.this.display_name
}

output "current_key_version" {
  description = "Current key version."
  value       = oci_kms_key.this.current_key_version
}
