# kms_key

Creates an OCI Vault key from a Vault management endpoint.

## Usage

```hcl
module "kms_key" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/kms_key"

  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
  display_name        = "key-app-dev"
  algorithm           = "AES"
  length              = 32
  protection_mode     = "HSM"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

`length` is measured in bytes: AES-256 uses 32. Automatic rotation remains explicit; when enabled it requires an integer interval of 60-365 days. Choose algorithm, protection mode, and rotation policy for the consuming service. Grant usage permissions separately and review key deletion impact.

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
| [oci_kms_key.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| algorithm | Key algorithm. | `string` | `"AES"` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| curve\_id | Curve ID for asymmetric EC keys. | `string` | `null` | no |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Key display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_auto\_rotation\_enabled | Whether automatic key rotation is enabled. | `bool` | `false` | no |
| length | Key length in bytes; AES-256 uses 32 bytes. | `number` | `32` | no |
| management\_endpoint | Vault management endpoint. | `string` | n/a | yes |
| protection\_mode | Key protection mode. | `string` | `"HSM"` | no |
| rotation\_interval\_in\_days | Automatic key rotation interval in days. | `number` | `null` | no |
| time\_of\_schedule\_start | Optional RFC3339 timestamp for automatic key rotation schedule start. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| current\_key\_version | Current key version. |
| display\_name | KMS key display name. |
| id | KMS key OCID. |
<!-- END_TF_DOCS -->
