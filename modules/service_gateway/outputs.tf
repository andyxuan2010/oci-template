output "id" {
  description = "Service gateway OCID."
  value       = oci_core_service_gateway.this.id
}

output "display_name" {
  description = "Service gateway display name."
  value       = oci_core_service_gateway.this.display_name
}
