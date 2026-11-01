output "id" {
  description = "Bucket resource ID."
  value       = oci_objectstorage_bucket.this.id
}

output "name" {
  description = "Bucket name."
  value       = oci_objectstorage_bucket.this.name
}

output "namespace" {
  description = "Bucket namespace."
  value       = oci_objectstorage_bucket.this.namespace
}
