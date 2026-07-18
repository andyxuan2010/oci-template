# dynamic_group Examples

## Basic Example

```hcl
module "dynamic_group" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/dynamic_group"

  compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name = "dg-app-dev"
  description = "Dynamic group for app dev instances"
  matching_rule = "ALL {instance.compartment.id = 'ocid1.compartment.oc1..exampleuniqueid'}"
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
