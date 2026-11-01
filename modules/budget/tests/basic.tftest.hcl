mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
    targets        = ["ocid1.compartment.oc1..exampleuniqueid"]
    amount         = 10
    display_name   = "budget-platform-dev"
    alert_rules = {
      eighty_percent = {
        threshold  = 80
        recipients = "platform@example.com"
      }
    }
  }
}
