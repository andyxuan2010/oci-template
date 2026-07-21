# service_gateway Examples

## Basic Example

```hcl
module "service_gateway" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/service_gateway"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "sgw-app-dev"
  services = [
    {
      service_id = "ocid1.service.oc1.iad.exampleuniqueid"
    }
  ]
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
