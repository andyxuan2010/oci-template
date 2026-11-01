# vault

Creates an OCI Vault for secrets and key-management foundations.

## Usage

```hcl
module "vault" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vault"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "vault-app-dev"
  vault_type     = "DEFAULT"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

The Vault is the foundation for keys and secrets, not a secret store by itself. Create keys with `kms_key` and values with `vault_secret`; grant consumer access through narrowly scoped IAM policies.

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
| [oci_kms_vault.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Vault display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| vault\_type | Vault type. | `string` | `"DEFAULT"` | no |

## Outputs

| Name | Description |
|------|-------------|
| crypto\_endpoint | Vault crypto endpoint. |
| id | Vault OCID. |
| management\_endpoint | Vault management endpoint. |
<!-- END_TF_DOCS -->
