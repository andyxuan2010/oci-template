# drg Examples

## Basic Composition

```hcl
module "drg" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/drg"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "drg-app-dev"
  vcn_attachments = {
    spoke = {
      vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Treat VCN attachments and DRG routing as separate ownership decisions. Review hub, on-premises, and cross-VCN reachability before attaching networks. Explicit OCIDs identify resources owned outside this module.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
