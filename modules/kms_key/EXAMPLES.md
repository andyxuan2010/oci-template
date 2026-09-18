# kms_key Examples

## Basic Example

```hcl
module "kms_key" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/kms_key"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
  display_name = "key-app-dev"
  algorithm = "AES"
  length = 32
  protection_mode = "HSM"
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
