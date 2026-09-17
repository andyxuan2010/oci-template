# vault Examples

## Basic Example

```hcl
module "vault" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/vault"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "vault-app-dev"
  vault_type = "DEFAULT"
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Notes

- Replace example OCIDs and names with values from the target OCI tenancy.
- Keep `freeform_tags` and `defined_tags` consistent with the root tagging standard.
- Run `terraform plan` before applying in a live tenancy.
