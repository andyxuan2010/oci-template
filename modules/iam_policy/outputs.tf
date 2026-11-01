output "id" {
  description = "Policy OCID."
  value       = oci_identity_policy.this.id
}

output "name" {
  description = "Policy name."
  value       = oci_identity_policy.this.name
}

output "statements" {
  description = "Policy statements."
  value       = oci_identity_policy.this.statements
}
