output "id" {
  description = "Autonomous Database OCID."
  value       = oci_database_autonomous_database.this.id
}

output "db_name" {
  description = "Database name."
  value       = oci_database_autonomous_database.this.db_name
}

output "private_endpoint" {
  description = "Private endpoint IP address."
  value       = oci_database_autonomous_database.this.private_endpoint
}
