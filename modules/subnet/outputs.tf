output "ids" {
  description = "Subnet OCIDs keyed by logical subnet name."
  value       = { for key, subnet in oci_core_subnet.this : key => subnet.id }
}

output "cidr_blocks" {
  description = "Subnet CIDR blocks keyed by logical subnet name."
  value       = { for key, subnet in oci_core_subnet.this : key => subnet.cidr_block }
}
