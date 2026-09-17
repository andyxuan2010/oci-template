# vcn Examples

## Basic Example

```hcl
module "vcn" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/vcn"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "vcn-app-dev"
  cidr_blocks = ["10.20.0.0/16"]
  dns_label = "appdev"
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
