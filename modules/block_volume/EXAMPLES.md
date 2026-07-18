# block_volume Examples

## Basic Example

```hcl
module "block_volume" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/block_volume"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name = "vol-app-dev-001"
  size_in_gbs = 100
  vpus_per_gb = 10
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
