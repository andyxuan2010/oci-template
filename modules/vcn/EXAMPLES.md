# vcn Examples

## Basic Composition

```hcl
module "vcn" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vcn"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "vcn-app-dev"
  cidr_blocks    = ["10.20.0.0/16"]
  dns_label      = "appdev"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Use non-overlapping IPv4 CIDRs. The VCN default security list is exposed for compatibility, but the root baseline uses a separate empty security list. Workload access is granted through NSGs.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
