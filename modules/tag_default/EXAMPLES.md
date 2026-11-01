# tag_default Examples

## Basic Composition

```hcl
module "environment_tag_default" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/tag_default"

  compartment_id    = var.compartment_id
  tag_definition_id = module.governance_tags.tag_ids["Environment"]
  value             = "dev"
  is_required       = true
}
```

## Deployment Notes

Tag defaults are compartment governance controls. Set `is_required` deliberately and confirm the deployment principal can read/use the tag definition. This OCI resource does not support freeform or defined tags of its own.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
