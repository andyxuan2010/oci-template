# iam_policy Examples

## Basic Composition

```hcl
module "iam_policy" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/iam_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name           = "policy-app-dev"
  description    = "Allow app operators to inspect instances"
  statements     = ["Allow group app-operators to inspect instances in compartment cmp-app-dev"]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Statements must be nonempty. This module does not parse the OCI authorization language or certify least privilege. Review subjects, verbs, resource families, compartment scope, and conditions; avoid tenancy-wide administrative statements for workloads.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
