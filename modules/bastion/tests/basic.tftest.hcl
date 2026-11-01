mock_provider "oci" {}

variables {
  compartment_id   = "ocid1.compartment.oc1..exampleuniqueid"
  target_subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  name             = "bastion-platform-dev"
  client_cidr_block_allow_list = [
    "203.0.113.10/32"
  ]

}

run "basic_plan" {
  command = plan


}

run "reject_world_clients" {
  command = plan
  variables {
    client_cidr_block_allow_list = ["::/0"]
  }
  expect_failures = [var.client_cidr_block_allow_list]
}

run "reject_empty_clients" {
  command = plan
  variables {
    client_cidr_block_allow_list = []
  }
  expect_failures = [oci_bastion_bastion.this]
}
