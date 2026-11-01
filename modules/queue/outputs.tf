output "id" {
  description = "Queue OCID."
  value       = oci_queue_queue.this.id
}

output "messages_endpoint" {
  description = "Queue messaging endpoint."
  value       = oci_queue_queue.this.messages_endpoint
}
