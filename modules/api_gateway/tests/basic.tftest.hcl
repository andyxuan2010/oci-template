mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "apigw-app-dev"
  subnet_id      = "ocid1.subnet.oc1.iad.exampleuniqueid"
  deployments = {
    app = {
      path_prefix = "/app"
      routes      = { health = { path = "/health", url = "https://backend.internal.example.com/health" } }
    }
  }
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = oci_apigateway_gateway.this.endpoint_type == "PRIVATE"
    error_message = "Gateway must be private by default."
  }
  assert {
    condition     = !oci_apigateway_deployment.this["app"].specification[0].routes[0].backend[0].is_ssl_verify_disabled
    error_message = "Backend TLS certificate verification must remain enabled."
  }
}

run "gateway_only" {
  command = plan
  variables {
    deployments = {}
  }
  assert {
    condition     = length(oci_apigateway_deployment.this) == 0
    error_message = "Deployments must be optional."
  }
}

run "reject_invalid_endpoint" {
  command = plan
  variables {
    endpoint_type = "INTERNET"
  }
  expect_failures = [var.endpoint_type]
}
