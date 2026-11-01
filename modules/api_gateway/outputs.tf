output "id" {
  description = "Gateway OCID."
  value       = oci_apigateway_gateway.this.id
}

output "hostname" {
  description = "Gateway hostname."
  value       = oci_apigateway_gateway.this.hostname
}

output "deployment_ids" {
  description = "Deployment OCIDs keyed by logical name."
  value       = { for k, d in oci_apigateway_deployment.this : k => d.id }
}

output "deployment_endpoints" {
  description = "Deployment URLs keyed by logical name."
  value       = { for k, d in oci_apigateway_deployment.this : k => d.endpoint }
}
