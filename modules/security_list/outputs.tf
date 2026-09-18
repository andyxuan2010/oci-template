output "id" {
  description = "Security list OCID."
  value       = oci_core_security_list.this.id
}

output "display_name" {
  description = "Security list display name."
  value       = oci_core_security_list.this.display_name
}
