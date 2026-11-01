output "id" {
  description = "Bastion OCID."
  value       = oci_bastion_bastion.this.id
}

output "private_endpoint_ip_address" {
  description = "Private endpoint IP address assigned to the bastion."
  value       = oci_bastion_bastion.this.private_endpoint_ip_address
}

output "state" {
  description = "Bastion lifecycle state."
  value       = oci_bastion_bastion.this.state
}
