# queue Examples

## Basic Composition

```hcl
module "queue" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/queue"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "queue-app-dev"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Grant producers and consumers IAM access separately. OCI Queue provides a built-in dead-letter queue; a delivery count of zero disables it. If using a customer-managed key, grant the Queue service the required key permissions. This module does not create consumer applications or private network endpoints.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
