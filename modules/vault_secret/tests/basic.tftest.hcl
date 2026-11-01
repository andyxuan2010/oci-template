mock_provider "oci" {}

variables {
  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vault_id       = "ocid1.vault.oc1.iad.exampleuniqueid"
  key_id         = "ocid1.key.oc1.iad.exampleuniqueid"
  secret_name    = "app-api-token"
  secret_content = "test-token-only"
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = oci_vault_secret.this.secret_content[0].content_type == "BASE64"
    error_message = "Vault requires base64 content."
  }
  assert {
    condition     = oci_vault_secret.this.secret_content[0].content == base64encode(var.secret_content)
    error_message = "Secret content must be encoded exactly once."
  }
}

run "metadata_and_tags" {
  command = plan
  variables {
    description   = "Application API token"
    freeform_tags = { environment = "dev" }
  }
  assert {
    condition     = oci_vault_secret.this.freeform_tags["environment"] == "dev"
    error_message = "Caller tags must be preserved."
  }
}
