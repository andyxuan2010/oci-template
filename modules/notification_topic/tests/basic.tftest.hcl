mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    name           = "topic-platform-dev"
    subscriptions = {
      platform_email = {
        protocol = "EMAIL"
        endpoint = "platform@example.com"
      }
    }
  }
}
