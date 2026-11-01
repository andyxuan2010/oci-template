output "id" {
  description = "Secret OCID."
  value       = oci_vault_secret.this.id
}

output "secret_name" {
  description = "Secret name."
  value       = oci_vault_secret.this.secret_name
}

output "current_version_number" {
  description = "Current secret version number."
  value       = oci_vault_secret.this.current_version_number
}
