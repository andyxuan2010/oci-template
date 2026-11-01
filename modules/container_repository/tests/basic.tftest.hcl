mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "platform/app"
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = !oci_artifacts_container_repository.this.is_public
    error_message = "Repository must be private by default."
  }
  assert {
    condition     = oci_artifacts_container_repository.this.is_immutable
    error_message = "Image tags must be immutable by default."
  }
}

run "explicit_public_repository" {
  command = plan
  variables {
    is_public    = true
    is_immutable = false
  }
  assert {
    condition     = oci_artifacts_container_repository.this.is_public && !oci_artifacts_container_repository.this.is_immutable
    error_message = "Explicit repository settings must be respected."
  }
}
