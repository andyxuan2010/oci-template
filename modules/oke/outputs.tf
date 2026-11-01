output "id" {
  description = "OKE cluster OCID."
  value       = oci_containerengine_cluster.this.id
}

output "endpoints" {
  description = "Cluster API endpoints."
  value       = oci_containerengine_cluster.this.endpoints
}

output "node_pool_ids" {
  description = "Managed worker pool OCIDs keyed by logical name."
  value       = { for k, p in oci_containerengine_node_pool.this : k => p.id }
}
