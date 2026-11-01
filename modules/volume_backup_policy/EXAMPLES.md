# volume_backup_policy Examples

## Basic Composition

```hcl
module "volume_backup_policy" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/volume_backup_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "backup-app-dev"
  asset_ids      = { data = "ocid1.volume.oc1.iad.exampleuniqueid" }
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Use this policy ID as `backup_policy_id` in the existing `block_volume` module, or manage assignments here with `asset_ids`. Assign each asset through only one module to avoid competing Terraform ownership. Cross-region copies require a supported region pair and IAM permissions. Retention locks and restore execution are managed separately.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
