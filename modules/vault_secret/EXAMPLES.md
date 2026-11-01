# vault_secret Examples

## Basic Composition

```hcl
module "vault_secret" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vault_secret"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vault_id       = "ocid1.vault.oc1.iad.exampleuniqueid"
  key_id         = "ocid1.key.oc1.iad.exampleuniqueid"
  secret_name    = "app-api-token"
  secret_content = var.api_token
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Declare `api_token` as a sensitive string variable in the calling configuration and supply it through a protected CI variable or `TF_VAR_api_token`. Secret values are stored in Terraform state even when marked sensitive. Use encrypted remote state with restricted IAM access. Rotation and secret consumers are managed separately; no secret value is exported.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
