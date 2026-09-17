output "id" {
  description = "Instance OCID."
  value       = oci_core_instance.this.id
}

output "private_ip" {
  description = "Primary private IP."
  value       = oci_core_instance.this.private_ip
}

output "public_ip" {
  description = "Primary public IP when assigned."
  value       = oci_core_instance.this.public_ip
}
