output "id" {
  description = "DNS zone OCID."
  value       = oci_dns_zone.this.id
}

output "name" {
  description = "DNS zone name."
  value       = oci_dns_zone.this.name
}

output "nameservers" {
  description = "Zone nameservers."
  value       = try(oci_dns_zone.this.nameservers, [])
}
