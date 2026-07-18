mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
    display_name   = "sgw-app-dev"
    services = [
      {
        service_id = "ocid1.service.oc1.iad.exampleuniqueid"
      }
    ]
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
