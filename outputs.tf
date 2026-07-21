output "compartment_id" {
  description = "Workload compartment OCID."
  value       = local.compartment_id
}

output "vcn_id" {
  description = "VCN OCID."
  value       = module.vcn.id
}

output "subnet_ids" {
  description = "Subnet OCIDs keyed by logical subnet name."
  value       = module.subnet.ids
}

output "network_security_group_id" {
  description = "Default NSG OCID."
  value       = module.network_security_group.id
}

output "route_table_id" {
  description = "Route table OCID."
  value       = module.route_table.id
}

output "compute_instance_id" {
  description = "Compute instance OCID when enabled."
  value       = try(module.compute_instance[0].id, null)
}

output "object_storage_bucket_name" {
  description = "Object Storage bucket name when enabled."
  value       = try(module.object_storage[0].name, null)
}

output "vault_id" {
  description = "Vault OCID when enabled."
  value       = try(module.vault[0].id, null)
}
