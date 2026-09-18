output "id" {
  description = "Route table OCID."
  value       = oci_core_route_table.this.id
}

output "internet_gateway_id" {
  description = "Internet gateway OCID when enabled."
  value       = try(oci_core_internet_gateway.this[0].id, null)
}

output "nat_gateway_id" {
  description = "NAT gateway OCID when enabled."
  value       = try(oci_core_nat_gateway.this[0].id, null)
}
