# subnet Examples

## Basic Example

```hcl
module "subnet" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/subnet"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  default_route_table_id = "ocid1.routetable.oc1.iad.exampleuniqueid"
  subnets = {
    app = {
      cidr_block = "10.20.1.0/24"
      dns_label = "app"
      prohibit_public_ip_on_vnic = true
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
