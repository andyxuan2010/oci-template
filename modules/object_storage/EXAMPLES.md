# object_storage Examples

## Basic Example

```hcl
module "object_storage" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/object_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  namespace = "exampletenancy"
  name = "bucket-app-dev"
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
