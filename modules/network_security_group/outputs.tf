output "id" {
  description = "NSG OCID."
  value       = oci_core_network_security_group.this.id
}

output "display_name" {
  description = "NSG display name."
  value       = oci_core_network_security_group.this.display_name
}
