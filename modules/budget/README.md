# budget

Creates an OCI budget and optional alert rules for a compartment or tag target.

## Usage

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

## Security and Operations

Budgets alert on spend; they do not stop resources or enforce a spending cap. Review currency, target scope, recipient addresses, and alert thresholds before deployment. Configure quota policies separately when capacity limits are needed.

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
| [oci_budget_alert_rule.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/budget_alert_rule) | resource |
| [oci_budget_budget.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/budget_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| alert\_rules | Budget alert rules keyed by a stable Terraform name. Recipients is a comma-separated email list. | <pre>map(object({<br>    threshold      = number<br>    recipients     = string<br>    threshold_type = optional(string, "PERCENTAGE")<br>    type           = optional(string, "ACTUAL")<br>    display_name   = optional(string)<br>    description    = optional(string)<br>    message        = optional(string)<br>  }))</pre> | `{}` | no |
| amount | Budget amount in the tenancy currency. | `number` | n/a | yes |
| compartment\_id | OCID of the tenancy or compartment that owns the budget resource. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Budget description. | `string` | `null` | no |
| display\_name | Budget display name. | `string` | n/a | yes |
| end\_date | Optional RFC3339 budget end date. | `string` | `null` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| processing\_period\_type | Budget processing period type. | `string` | `null` | no |
| reset\_period | Budget reset period. | `string` | `"MONTHLY"` | no |
| start\_date | Optional RFC3339 budget start date. | `string` | `null` | no |
| target\_type | Budget target type, normally COMPARTMENT or TAG. | `string` | `"COMPARTMENT"` | no |
| targets | Target compartment OCIDs or tag values tracked by the budget. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alert\_rule\_ids | Budget alert rule OCIDs keyed by rule name. |
| id | Budget OCID. |
<!-- END_TF_DOCS -->
