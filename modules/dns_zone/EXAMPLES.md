# dns_zone Examples

## Basic Example

```hcl
module "dns_zone" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/dns_zone"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name = "example.internal"
  zone_type = "PRIMARY"
  scope = "GLOBAL"
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
