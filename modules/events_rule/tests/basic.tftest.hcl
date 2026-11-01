mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "events-storage-dev"
  condition      = jsonencode({ eventType = ["com.oraclecloud.objectstorage.createbucket"] })
  actions = {
    notify = { action_type = "ONS", topic_id = "ocid1.onstopic.oc1.iad.exampleuniqueid" }
  }
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = oci_events_rule.this.is_enabled
    error_message = "Event routing must be enabled by default."
  }
  assert {
    condition     = length(oci_events_rule.this.actions[0].action) == 1
    error_message = "One notification action must be configured."
  }
}

run "function_destination" {
  command = plan
  variables {
    actions = { invoke = { action_type = "FAAS", function_id = "ocid1.fnfunc.oc1.iad.exampleuniqueid" } }
  }
  assert {
    condition     = one(oci_events_rule.this.actions[0].action).action_type == "FAAS"
    error_message = "Function destination must be wired."
  }
}

run "reject_mismatched_destination" {
  command = plan
  variables {
    actions = { bad = { action_type = "ONS", function_id = "ocid1.fnfunc.oc1.iad.exampleuniqueid" } }
  }
  expect_failures = [var.actions]
}
