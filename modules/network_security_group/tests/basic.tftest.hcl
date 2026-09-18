mock_provider "oci" {}

run "basic_plan" {
  command = plan

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
}
