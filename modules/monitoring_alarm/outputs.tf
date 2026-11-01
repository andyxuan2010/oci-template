output "id" {
  description = "Monitoring alarm OCID."
  value       = oci_monitoring_alarm.this.id
}

output "state" {
  description = "Monitoring alarm lifecycle state."
  value       = oci_monitoring_alarm.this.state
}
