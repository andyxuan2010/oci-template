mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "fnapp-app-dev"
  subnet_ids     = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  functions = {
    worker = { image = "iad.ocir.io/exampletenancy/platform/worker:1.0.0" }
  }
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = tonumber(oci_functions_function.this["worker"].memory_in_mbs) == 256
    error_message = "Functions must use the default memory allocation."
  }
  assert {
    condition     = oci_functions_function.this["worker"].image == var.functions["worker"].image
    error_message = "Function image must be wired from the caller."
  }
}

run "application_only" {
  command = plan
  variables {
    functions = {}
  }
  assert {
    condition     = length(oci_functions_function.this) == 0
    error_message = "An application can be created before image deployment."
  }
}

run "reject_unsupported_memory" {
  command = plan
  variables {
    functions = { worker = { image = "iad.ocir.io/exampletenancy/platform/worker:1.0.0", memory_in_mbs = 1 } }
  }
  expect_failures = [var.functions]
}
