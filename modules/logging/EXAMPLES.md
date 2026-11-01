# logging Examples

## Basic Composition

```hcl
module "logging" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/logging"

  compartment_id = var.compartment_id
  display_name   = "logs-platform-dev"
  description    = "Landing-zone service logs"

  logs = {
    vcn_flow = {
      display_name       = "vcn-flow-platform-dev"
      retention_duration = 30
      configuration = {
        category = "all"
        resource = module.vcn.id
        service  = "flowlogs"
      }
    }
  }
}
```

## Deployment Notes

Enable only service categories offered by the target resource and region. Retention defaults to 30 days for configured logs. Review retention, log-reader IAM, and application redaction because log content can contain sensitive data.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
