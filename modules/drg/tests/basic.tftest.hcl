mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    display_name   = "drg-app-dev"
    vcn_attachments = {
      spoke = {
        vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
      }
    }
    freeform_tags = {
      environment = "dev"
      managed_by  = "terraform"
    }
  }
}
