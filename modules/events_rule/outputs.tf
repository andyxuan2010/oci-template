output "id" {
  description = "Events rule OCID."
  value       = oci_events_rule.this.id
}

output "display_name" {
  description = "Events rule display name."
  value       = oci_events_rule.this.display_name
}
