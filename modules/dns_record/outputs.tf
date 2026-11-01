output "id" {
  description = "DNS record set resource ID."
  value       = oci_dns_rrset.this.id
}

output "domain" {
  description = "Record domain name."
  value       = oci_dns_rrset.this.domain
}

output "rtype" {
  description = "Record type."
  value       = oci_dns_rrset.this.rtype
}
