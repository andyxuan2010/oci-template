# tag_namespace Examples

## Basic Composition

```hcl
module "governance_tags" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/tag_namespace"

  compartment_id = var.tenancy_ocid
  name           = "Governance"
  description    = "Landing-zone governance tags"

  tags = {
    Environment = {
      description      = "Deployment environment"
      is_cost_tracking = true
      validator = {
        validator_type = "ENUM"
        values         = ["dev", "sandbox", "prod"]
      }
    }
    Owner = {
      description = "Owning team"
    }
  }
}
```

## Deployment Notes

Tag namespaces and definitions must exist before callers use defined tags. Validator values and cost-tracking choices are organization policy; review retirement and deletion impacts on existing resources.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
