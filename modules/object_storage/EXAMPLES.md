# object_storage Examples

## Basic Composition

```hcl
module "object_storage" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/object_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  namespace      = "exampletenancy"
  name           = "bucket-app-dev"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Buckets default to `NoPublicAccess` and enabled versioning. Public access requires an explicit `access_type`; do not use it for state or confidential objects. Optional `kms_key_id` selects a customer-managed key and requires Object Storage key permissions. `object_events_enabled` enables object-level Events integration. Retention rules and deletion protection require workload-specific policy.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
