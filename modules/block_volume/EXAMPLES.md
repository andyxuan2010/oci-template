# block_volume Examples

## Basic Composition

```hcl
module "block_volume" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/block_volume"

  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name        = "vol-app-dev-001"
  size_in_gbs         = 100
  vpus_per_gb         = 10
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Paravirtualized attachments enable encryption in transit by default and require compatible instances. The flag is omitted for iSCSI/NVMe; iSCSI authentication and transport security require a separate design. Use a backup policy and a customer-managed key when required. Manage each backup assignment through this module or `volume_backup_policy`, never both.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
