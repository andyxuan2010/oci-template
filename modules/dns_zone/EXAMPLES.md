# dns_zone Examples

## Basic Composition

```hcl
module "dns_zone" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dns_zone"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name           = "example.internal"
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Zones now default to `PRIVATE`; use `scope = "GLOBAL"` explicitly for public DNS. Changing scope on an existing zone may require replacement. Supply the appropriate private view and resolver associations for the network design. Use `dns_record` to manage individual record sets.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
