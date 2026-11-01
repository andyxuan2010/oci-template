# monitoring_alarm

Creates one OCI Monitoring alarm with notification destinations and an optional suppression window.

## Usage

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

## Security and Operations

Metric queries, namespaces, destinations, and IAM permissions must match the target tenancy. Alarms are enabled by default; suppression windows and repeat intervals should reflect the on-call operating model.

Authentication is supplied by the calling configuration; this module declares no provider credentials. Taggable resources accept caller-owned `freeform_tags` and `defined_tags`. See [EXAMPLES.md](EXAMPLES.md), the [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).

## Validation

From this module directory:

```powershell
terraform init -backend=false
terraform validate
terraform test
```

[tests/basic.tftest.hcl](tests/basic.tftest.hcl) runs mock-provider plans without OCI credentials or creating resources. Live service availability, permissions, quotas, and network connectivity require a target-tenancy plan.

## Generated Reference

The tables below are generated from Terraform using `scripts/Update-ModuleDocs.ps1`; do not edit them manually.

## Testing

Run the module tests from this directory:

```sh
terraform init -backend=false
terraform test
```

The test files are in [tests](tests).

## Examples

- [Basic](examples/basic): minimal configuration.
- [Complete](examples/complete): every optional input set.

## Providers

| Name | Source | Version |
| --- | --- | --- |
| oci | oracle/oci | >= 8.23.0, < 9.0.0 |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7.0 |
| oci | >= 8.23.0, < 9.0.0 |

## Resources

| Name | Type |
|------|------|
| [oci_monitoring_alarm.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/monitoring_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alarm\_summary | Alarm summary included in notifications. | `string` | `null` | no |
| body | Notification body. | `string` | `null` | no |
| compartment\_id | Compartment OCID that owns the alarm. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| destinations | Notification topic OCIDs. | `list(string)` | n/a | yes |
| display\_name | Alarm display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_enabled | Whether alarm evaluation and notifications are enabled. | `bool` | `true` | no |
| is\_notifications\_per\_metric\_dimension\_enabled | Send notifications for each metric stream dimension. | `bool` | `false` | no |
| message\_format | Alarm message format, such as RAW or PRETTY\_JSON. | `string` | `null` | no |
| metric\_compartment\_id | Compartment OCID containing the monitored metrics. | `string` | n/a | yes |
| metric\_compartment\_id\_in\_subtree | Whether metrics in child compartments are included. | `bool` | `false` | no |
| namespace | Monitoring metric namespace, such as oci\_computeagent. | `string` | n/a | yes |
| notification\_title | Optional notification title. | `string` | `null` | no |
| pending\_duration | ISO-8601 duration that the condition must persist before firing. | `string` | `"PT5M"` | no |
| query | Monitoring Query Language expression. | `string` | n/a | yes |
| repeat\_notification\_duration | ISO-8601 interval for repeated notifications. Null disables repeats. | `string` | `null` | no |
| resolution | Metric query resolution. | `string` | `null` | no |
| resource\_group | Optional metric resource group. | `string` | `null` | no |
| severity | Alarm severity. | `string` | `"WARNING"` | no |
| suppression | Optional scheduled alarm suppression window. | <pre>object({<br>    time_suppress_from  = string<br>    time_suppress_until = string<br>    description         = optional(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Monitoring alarm OCID. |
| state | Monitoring alarm lifecycle state. |
<!-- END_TF_DOCS -->
