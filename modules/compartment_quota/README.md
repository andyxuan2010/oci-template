# compartment_quota

Creates an OCI quota policy from explicit quota statements.

## Usage

```hcl
module "compartment_quota" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/compartment_quota"

  compartment_id = var.tenancy_ocid
  name           = "quota-platform-dev"
  description    = "Prevent unapproved development capacity"
  statements = [
    "zero compute-core quotas in compartment platform-dev",
    "set compute-core quota standard-a1-core-count to 4 in compartment platform-dev"
  ]
}
```

## Security and Operations

Quota statements are explicit OCI policy syntax and must be reviewed against available service quota names. Quotas are capacity controls, not cost caps; pair them with budgets and alerts.

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
| [oci_limits_quota.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/limits_quota) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | OCID of the compartment that owns the quota policy. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Quota policy description. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| name | Quota policy name. | `string` | n/a | yes |
| statements | OCI quota policy statements. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Quota policy OCID. |
| name | Quota policy name. |
<!-- END_TF_DOCS -->
