output "id" {
  description = "Repository OCID."
  value       = oci_artifacts_container_repository.this.id
}

output "display_name" {
  description = "Repository name."
  value       = oci_artifacts_container_repository.this.display_name
}

output "namespace" {
  description = "Registry tenancy namespace."
  value       = oci_artifacts_container_repository.this.namespace
}
