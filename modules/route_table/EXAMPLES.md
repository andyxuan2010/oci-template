# route_table Examples

## Basic Example

```hcl
module "route_table" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/route_table"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "rt-app-dev"
  enable_nat_gateway = true
  route_rules = [
    {
      destination = "0.0.0.0/0"
      network_entity = "nat_gateway"
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
