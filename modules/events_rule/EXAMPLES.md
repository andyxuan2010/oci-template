# events_rule Examples

## Basic Composition

```hcl
module "events_rule" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/events_rule"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "events-storage-dev"
  condition      = jsonencode({ eventType = ["com.oraclecloud.objectstorage.createbucket"] })
  actions = {
    notify = { action_type = "ONS", topic_id = "ocid1.onstopic.oc1.iad.exampleuniqueid" }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Create destination resources first and grant the Events service permission to deliver to them. Conditions use `jsonencode` and provider-supported `condition` for compatibility with OCI provider 8.23. Object-level Object Storage events also require event emission on the source bucket. This module does not route directly to OCI Queue.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
