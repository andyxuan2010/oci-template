# tag_default

Creates one OCI tag default for a compartment and tag definition.

## Usage

```hcl
module "environment_tag_default" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/tag_default"

  compartment_id    = var.compartment_id
  tag_definition_id = module.governance_tags.tag_ids["Environment"]
  value             = "dev"
  is_required       = true
}
```

## Security and Operations

Tag defaults are compartment governance controls. Set `is_required` deliberately and confirm the deployment principal can read/use the tag definition. This OCI resource does not support freeform or defined tags of its own.

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
| [oci_identity_tag_default.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag_default) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | OCID of the compartment where the tag default applies. | `string` | n/a | yes |
| is\_required | Whether resource creation fails when the default tag cannot be applied. | `bool` | `false` | no |
| tag\_definition\_id | OCID of the tag definition used by the default. | `string` | n/a | yes |
| value | Default tag value. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Tag default OCID. |
| tag\_definition\_name | Name of the tag definition used by the default. |
<!-- END_TF_DOCS -->
