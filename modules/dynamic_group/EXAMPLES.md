# dynamic_group Examples

## Basic Composition

```hcl
module "dynamic_group" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dynamic_group"

  compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name           = "dg-app-dev"
  description    = "Dynamic group for app dev instances"
  matching_rule  = "ALL {instance.compartment.id = 'ocid1.compartment.oc1..exampleuniqueid'}"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Provide a nonempty, narrowly scoped matching rule. A dynamic group grants no permissions by itself; pair it with reviewed IAM statements. Avoid matching every instance or resource in the tenancy.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
