# compartment Examples

## Basic Example

```hcl
module "compartment" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/compartment"

  parent_compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name = "cmp-app-dev"
  description = "Compartment for app dev resources"
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
