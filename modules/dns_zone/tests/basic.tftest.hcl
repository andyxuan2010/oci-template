mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name           = "example.internal"
  zone_type      = "PRIMARY"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "private_zone_default" {
  command = plan
  variables {
    scope = "PRIVATE"
  }
  assert {
    condition     = oci_dns_zone.this.scope == "PRIVATE"
    error_message = "Private DNS zones must be supported."
  }
}

run "explicit_public_zone" {
  command = plan
  variables {
    scope = "GLOBAL"
  }
  assert {
    condition     = oci_dns_zone.this.scope == "GLOBAL"
    error_message = "Public zone scope must require explicit selection."
  }
}
