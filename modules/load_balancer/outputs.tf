output "id" {
  description = "Load balancer OCID."
  value       = oci_load_balancer_load_balancer.this.id
}

output "ip_address_details" {
  description = "Load balancer IP address details."
  value       = oci_load_balancer_load_balancer.this.ip_address_details
}

output "backend_set_names" {
  description = "Backend set names."
  value       = keys(oci_load_balancer_backend_set.this)
}

output "listener_names" {
  description = "Listener names."
  value       = keys(oci_load_balancer_listener.this)
}
