# vault_secret

Stores a sensitive value as a base64-encoded OCI Vault secret using an existing Vault and symmetric KMS key.

## Usage

```hcl
module "vault_secret" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vault_secret"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vault_id       = "ocid1.vault.oc1.iad.exampleuniqueid"
  key_id         = "ocid1.key.oc1.iad.exampleuniqueid"
  secret_name    = "app-api-token"
  secret_content = var.api_token
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Declare `api_token` as a sensitive string variable in the calling configuration and supply it through a protected CI variable or `TF_VAR_api_token`. Secret values are stored in Terraform state even when marked sensitive. Use encrypted remote state with restricted IAM access. Rotation and secret consumers are managed separately; no secret value is exported.

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
| [oci_vault_secret.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/vault_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Secret description. | `string` | `null` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| key\_id | Symmetric encryption key OCID in the Vault. | `string` | n/a | yes |
| secret\_content | Plaintext secret value; encoded once by this module. | `string` | n/a | yes |
| secret\_name | Secret name. | `string` | n/a | yes |
| vault\_id | Vault OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| current\_version\_number | Current secret version number. |
| id | Secret OCID. |
| secret\_name | Secret name. |
<!-- END_TF_DOCS -->
