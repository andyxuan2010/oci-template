# drg Examples

## Basic Example

```hcl
module "drg" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/drg"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "drg-app-dev"
  vcn_attachments = {
    spoke = {
      vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
    }
  }
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
