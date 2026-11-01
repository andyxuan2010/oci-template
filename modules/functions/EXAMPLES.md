# functions Examples

## Basic Composition

```hcl
module "functions" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/functions"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "fnapp-app-dev"
  subnet_ids     = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  functions = {
    worker = { image = "iad.ocir.io/exampletenancy/platform/worker:1.0.0" }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Build and push compatible function images to `container_repository` before deploying functions. Select private subnets with access to OCI Registry through appropriate service/NAT gateways. Configure IAM for image pulls and invocation separately. The module cannot verify whether a supplied subnet is private. Fetch secrets at runtime through resource principals and `vault_secret`; environment configuration is stored in state and must not contain secrets.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
