output "id" {
  description = "Backup policy OCID."
  value       = oci_core_volume_backup_policy.this.id
}

output "assignment_ids" {
  description = "Assignment OCIDs keyed by asset name."
  value       = { for k, a in oci_core_volume_backup_policy_assignment.this : k => a.id }
}
