mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id     = "ocid1.compartment.oc1..exampleuniqueid"
    vcn_id             = "ocid1.vcn.oc1.iad.exampleuniqueid"
    display_name       = "rt-app-dev"
    enable_nat_gateway = true
    route_rules = [
      {
        destination    = "0.0.0.0/0"
        network_entity = "nat_gateway"
      }
    ]
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
