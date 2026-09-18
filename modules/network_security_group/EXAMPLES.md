# network_security_group Examples

## Basic Example

```hcl
module "network_security_group" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/network_security_group"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "nsg-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source = "10.20.0.0/16"
      tcp_options = {
        min = 22
        max = 22
      }
    }
  ]
  egress_rules = [
    {
      protocol = "all"
      destination = "0.0.0.0/0"
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
