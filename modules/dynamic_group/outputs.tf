output "id" {
  description = "Dynamic group OCID."
  value       = oci_identity_dynamic_group.this.id
}

output "name" {
  description = "Dynamic group name."
  value       = oci_identity_dynamic_group.this.name
}

output "matching_rule" {
  description = "Dynamic group matching rule."
  value       = oci_identity_dynamic_group.this.matching_rule
}
