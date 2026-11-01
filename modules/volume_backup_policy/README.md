# volume_backup_policy

Creates a reusable user-defined block/boot volume backup policy with optional asset assignments.

## Usage

```hcl
module "volume_backup_policy" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/volume_backup_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "backup-app-dev"
  asset_ids      = { data = "ocid1.volume.oc1.iad.exampleuniqueid" }
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Use this policy ID as `backup_policy_id` in the existing `block_volume` module, or manage assignments here with `asset_ids`. Assign each asset through only one module to avoid competing Terraform ownership. Cross-region copies require a supported region pair and IAM permissions. Retention locks and restore execution are managed separately.

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
| [oci_core_volume_backup_policy.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy) | resource |
| [oci_core_volume_backup_policy_assignment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| asset\_ids | Boot volume, block volume, or volume group OCIDs keyed by stable logical name. | `map(string)` | `{}` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| destination\_region | Optional supported paired region for backup copies. | `string` | `null` | no |
| display\_name | Backup policy display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| schedules | Backup schedules keyed by logical name. | <pre>map(object({<br>    period            = optional(string, "ONE_DAY")<br>    backup_type       = optional(string, "INCREMENTAL")<br>    retention_seconds = optional(number, 604800)<br>    hour_of_day       = optional(number, 2)<br>    day_of_week       = optional(string)<br>    day_of_month      = optional(number)<br>    month             = optional(string)<br>    time_zone         = optional(string, "UTC")<br>  }))</pre> | <pre>{<br>  "daily": {}<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| assignment\_ids | Assignment OCIDs keyed by asset name. |
| id | Backup policy OCID. |
<!-- END_TF_DOCS -->
