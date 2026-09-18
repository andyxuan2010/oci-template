mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id         = "ocid1.compartment.oc1..exampleuniqueid"
    vcn_id                 = "ocid1.vcn.oc1.iad.exampleuniqueid"
    default_route_table_id = "ocid1.routetable.oc1.iad.exampleuniqueid"
    subnets = {
      app = {
        cidr_block                 = "10.20.1.0/24"
        dns_label                  = "app"
        prohibit_public_ip_on_vnic = true
      }
    }
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
