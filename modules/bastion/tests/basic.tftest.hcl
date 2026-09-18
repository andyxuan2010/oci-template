mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id   = "ocid1.compartment.oc1..exampleuniqueid"
    target_subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
    name             = "bastion-platform-dev"
    client_cidr_block_allow_list = [
      "203.0.113.10/32"
    ]
  }
}
