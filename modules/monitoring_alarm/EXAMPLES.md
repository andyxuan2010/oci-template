# monitoring_alarm Examples

## Basic Composition

```hcl
module "compute_cpu_alarm" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/monitoring_alarm"

  compartment_id        = var.compartment_id
  metric_compartment_id = var.compartment_id
  display_name          = "alarm-compute-cpu-dev"
  namespace             = "oci_computeagent"
  query                 = "CpuUtilization[5m].mean() > 80"
  severity              = "WARNING"
  destinations          = [module.notification_topic.topic_id]
  pending_duration      = "PT5M"
}
```

## Deployment Notes

Metric queries, namespaces, destinations, and IAM permissions must match the target tenancy. Alarms are enabled by default; suppression windows and repeat intervals should reflect the on-call operating model.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
