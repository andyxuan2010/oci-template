mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "nsg-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source   = "10.20.0.0/16"
      tcp_options = {
        min = 22
        max = 22
      }
    }
  ]
  egress_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
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

run "reject_world_ssh" {
  command = plan
  variables {
    ingress_rules = [{ source = "0.0.0.0/0", protocol = "6", tcp_options = { min = 22, max = 22 } }]
  }
  expect_failures = [oci_core_network_security_group.this]
}

run "reject_world_ipv6_rdp" {
  command = plan
  variables {
    ingress_rules = [{ source = "::/0", protocol = "17", udp_options = { min = 3389, max = 3389 } }]
  }
  expect_failures = [oci_core_network_security_group.this]
}

run "reject_world_all_protocols" {
  command = plan
  variables {
    ingress_rules = [{ source = "0.0.0.0/0", protocol = "all" }]
  }
  expect_failures = [oci_core_network_security_group.this]
}

run "public_https_is_allowed" {
  command = plan
  variables {
    ingress_rules = [{ source = "0.0.0.0/0", protocol = "6", tcp_options = { min = 443, max = 443 } }]
  }
}

run "explicit_management_exception" {
  command = plan
  variables {
    allow_unrestricted_management_ingress = true
    ingress_rules                         = [{ source = "0.0.0.0/0", protocol = "6", tcp_options = { min = 22, max = 22 } }]
  }
}

run "reject_invalid_port_range" {
  command = plan
  variables {
    ingress_rules = [{ source = "10.20.0.0/16", protocol = "6", tcp_options = { min = 100, max = 22 } }]
  }
  expect_failures = [var.ingress_rules]
}
