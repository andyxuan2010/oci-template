# OCI Vault Module

Creates an OCI Vault for secrets and key-management foundations.

## Usage

Use this before creating keys or secrets that require managed cryptographic isolation.

```hcl
module "vault" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/vault"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "vault-app-dev"
  vault_type = "DEFAULT"
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Compartment OCID. |
| `display_name` | `string` | Yes | Vault display name. |
| `vault_type` | `string` | No | Vault type. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Vault OCID. |
| `management_endpoint` | Vault management endpoint. |
| `crypto_endpoint` | Vault crypto endpoint. |

## Examples

See [EXAMPLES.md](./EXAMPLES.md) for a complete example.

## Terraform Tests

This module includes a mock-provider plan test at [tests/basic.tftest.hcl](./tests/basic.tftest.hcl). Run it from the module directory:

```powershell
terraform init -backend=false
terraform test
```

The repository-level validation helper also validates module syntax:

```powershell
.\test.ps1 modules\vault\main.tf
```
