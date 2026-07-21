mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    display_name   = "logs-platform-dev"
    logs = {
      vcn_flow = {
        display_name = "vcn-flow-platform-dev"
        configuration = {
          category = "all"
          resource = "ocid1.vcn.oc1.iad.exampleuniqueid"
          service  = "flowlogs"
        }
      }
    }
  }
}
