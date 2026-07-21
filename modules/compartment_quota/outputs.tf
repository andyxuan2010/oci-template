output "id" {
  description = "Quota policy OCID."
  value       = oci_limits_quota.this.id
}

output "name" {
  description = "Quota policy name."
  value       = oci_limits_quota.this.name
}
