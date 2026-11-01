# vault Examples

## Basic Composition

```hcl
module "vault" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vault"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "vault-app-dev"
  vault_type     = "DEFAULT"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

The Vault is the foundation for keys and secrets, not a secret store by itself. Create keys with `kms_key` and values with `vault_secret`; grant consumer access through narrowly scoped IAM policies.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
