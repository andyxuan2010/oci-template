mock_provider "oci" {}

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

run "basic_plan" {
  command = plan


}

run "reject_disabled_nat" {
  command = plan
  variables {
    enable_nat_gateway = false
    route_rules        = [{ destination = "0.0.0.0/0", network_entity = "nat_gateway" }]
  }
  expect_failures = [oci_core_route_table.this]
}

run "reject_disabled_internet" {
  command = plan
  variables {
    enable_internet_gateway = false
    route_rules             = [{ destination = "0.0.0.0/0", network_entity = "internet_gateway" }]
  }
  expect_failures = [oci_core_route_table.this]
}
