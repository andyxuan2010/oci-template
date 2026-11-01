output "file_system_id" {
  description = "File system OCID."
  value       = oci_file_storage_file_system.this.id
}

output "mount_target_id" {
  description = "Mount target OCID."
  value       = oci_file_storage_mount_target.this.id
}

output "mount_target_ip_address" {
  description = "Mount target IP address."
  value       = oci_file_storage_mount_target.this.ip_address
}

output "export_id" {
  description = "Export OCID."
  value       = oci_file_storage_export.this.id
}

output "export_path" {
  description = "NFS export path."
  value       = oci_file_storage_export.this.path
}
