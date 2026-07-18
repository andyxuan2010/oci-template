output "id" {
  description = "VCN OCID."
  value       = oci_core_vcn.this.id
}

output "cidr_blocks" {
  description = "VCN CIDR blocks."
  value       = oci_core_vcn.this.cidr_blocks
}

output "default_security_list_id" {
  description = "Default VCN security list OCID."
  value       = oci_core_vcn.this.default_security_list_id
}

output "default_route_table_id" {
  description = "Default VCN route table OCID."
  value       = oci_core_vcn.this.default_route_table_id
}
