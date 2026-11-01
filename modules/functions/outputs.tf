output "id" {
  description = "Functions application OCID."
  value       = oci_functions_application.this.id
}

output "function_ids" {
  description = "Function OCIDs keyed by function name."
  value       = { for k, f in oci_functions_function.this : k => f.id }
}

output "invoke_endpoints" {
  description = "Function invocation URLs keyed by function name."
  value       = { for k, f in oci_functions_function.this : k => f.invoke_endpoint }
}
