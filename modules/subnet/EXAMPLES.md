# subnet Examples

## Basic Composition

```hcl
module "subnet" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/subnet"

  compartment_id         = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id                 = "ocid1.vcn.oc1.iad.exampleuniqueid"
  default_route_table_id = "ocid1.routetable.oc1.iad.exampleuniqueid"
  subnets = {
    app = {
      cidr_block                 = "10.20.1.0/24"
      dns_label                  = "app"
      prohibit_public_ip_on_vnic = true
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Subnets are private by default. Set security-list and route-table ownership explicitly. `security_list_ids` output reports the applied lists. The nested `nsg_ids` input is retained only for compatibility and has no effect: attach NSGs to compute VNICs, mount targets, gateways, or load balancers instead.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
