output "log_group_id" {
  description = "Log group OCID."
  value       = oci_logging_log_group.this.id
}

output "log_ids" {
  description = "Log OCIDs keyed by log name."
  value       = { for name, log in oci_logging_log.this : name => log.id }
}
