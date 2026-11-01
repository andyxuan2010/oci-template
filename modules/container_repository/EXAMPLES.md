# container_repository Examples

## Basic Composition

```hcl
module "container_repository" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/container_repository"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "platform/app"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Build and push images separately using OCI Registry authentication. Grant pull permissions to OKE nodes and Functions through narrow IAM policies; this module does not create credentials or build images.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
