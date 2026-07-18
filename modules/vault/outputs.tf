output "id" {
  description = "Vault OCID."
  value       = oci_kms_vault.this.id
}

output "management_endpoint" {
  description = "Vault management endpoint."
  value       = oci_kms_vault.this.management_endpoint
}

output "crypto_endpoint" {
  description = "Vault crypto endpoint."
  value       = oci_kms_vault.this.crypto_endpoint
}
