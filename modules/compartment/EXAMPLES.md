# compartment Examples

## Basic Composition

```hcl
module "compartment" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/compartment"

  parent_compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name                  = "cmp-app-dev"
  description           = "Compartment for app dev resources"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Choose an explicit parent compartment and grant the deployment principal only the permissions it needs. `enable_delete` controls OCI compartment deletion; review destroy plans and child-resource ownership before enabling deletion.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
