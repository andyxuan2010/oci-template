# bastion Examples

## Basic Composition

```hcl
module "bastion" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/bastion"

  compartment_id   = var.compartment_id
  target_subnet_id = module.subnet.ids["private"]
  name             = "bastion-platform-dev"
  client_cidr_block_allow_list = [
    "203.0.113.10/32"
  ]
  max_session_ttl_in_seconds = 3600
}
```

## Deployment Notes

STANDARD Bastions require at least one valid client CIDR narrower than /0. Use individual administrator addresses or narrow corporate ranges, short session lifetimes, and separate IAM authorization. INTERNAL settings are optional and must match the target service capabilities.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
