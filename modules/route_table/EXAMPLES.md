# route_table Examples

## Basic Composition

```hcl
module "route_table" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/route_table"

  compartment_id     = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id             = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name       = "rt-app-dev"
  enable_nat_gateway = true
  route_rules = [
    {
      destination    = "0.0.0.0/0"
      network_entity = "nat_gateway"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

NAT and internet gateways are optional and disabled by default in this module. A symbolic gateway reference requires that gateway to be enabled. Use service gateways for private OCI service access where supported; destination rules and outbound access remain caller-owned.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
