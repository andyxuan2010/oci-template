# kms_key Examples

## Basic Composition

```hcl
module "kms_key" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/kms_key"

  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
  display_name        = "key-app-dev"
  algorithm           = "AES"
  length              = 32
  protection_mode     = "HSM"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

`length` is measured in bytes: AES-256 uses 32. Automatic rotation remains explicit; when enabled it requires an integer interval of 60-365 days. Choose algorithm, protection mode, and rotation policy for the consuming service. Grant usage permissions separately and review key deletion impact.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
