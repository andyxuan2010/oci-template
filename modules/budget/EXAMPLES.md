# budget Examples

## Basic Composition

```hcl
module "budget" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/budget"

  compartment_id = var.tenancy_ocid
  targets        = [var.workload_compartment_id]
  display_name   = "budget-platform-dev"
  amount         = 10

  alert_rules = {
    eighty_percent = {
      threshold  = 80
      recipients = "platform@example.com"
      message    = "The development budget reached 80 percent."
    }
    forecast = {
      threshold  = 100
      type       = "FORECAST"
      recipients = "platform@example.com"
    }
  }
}
```

## Deployment Notes

Budgets alert on spend; they do not stop resources or enforce a spending cap. Review currency, target scope, recipient addresses, and alert thresholds before deployment. Configure quota policies separately when capacity limits are needed.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
