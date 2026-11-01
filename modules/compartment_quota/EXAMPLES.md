# compartment_quota Examples

## Basic Composition

```hcl
module "compartment_quota" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/compartment_quota"

  compartment_id = var.tenancy_ocid
  name           = "quota-platform-dev"
  description    = "Prevent unapproved development capacity"
  statements = [
    "zero compute-core quotas in compartment platform-dev",
    "set compute-core quota standard-a1-core-count to 4 in compartment platform-dev"
  ]
}
```

## Deployment Notes

Quota statements are explicit OCI policy syntax and must be reviewed against available service quota names. Quotas are capacity controls, not cost caps; pair them with budgets and alerts.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
