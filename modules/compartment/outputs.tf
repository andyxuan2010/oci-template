output "id" {
  description = "Compartment OCID."
  value       = oci_identity_compartment.this.id
}

output "name" {
  description = "Compartment name."
  value       = oci_identity_compartment.this.name
}
