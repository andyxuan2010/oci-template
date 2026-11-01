# autonomous_database Examples

## Basic Composition

```hcl
module "autonomous_database" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/autonomous_database"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "adb-app-dev"
  db_name        = "APPDEV"
  admin_password = var.database_admin_password
  subnet_id      = "ocid1.subnet.oc1.iad.exampleuniqueid"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Declare `database_admin_password` as a sensitive string variable in the caller and supply it from protected CI inputs. The password remains in Terraform state. Provide a private subnet, DNS resolution, and NSG rules for database clients. Choose region-supported ECPU capacity and review licensing and costs before applying. Wallet distribution, database users, schema migrations, and disaster recovery are outside this module.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
