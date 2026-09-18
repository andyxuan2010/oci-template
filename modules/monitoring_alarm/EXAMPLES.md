# Monitoring Alarm Examples

```hcl
module "compute_cpu_alarm" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/monitoring_alarm"

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
