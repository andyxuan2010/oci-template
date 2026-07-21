# OCI Kms Key Module

Creates an OCI Vault key from a Vault management endpoint.

## Usage

Use this when storage or platform resources need customer-managed encryption keys.

```hcl
module "kms_key" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/kms_key"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  management_endpoint = "https://example-management.crypto.us-ashburn-1.oraclecloud.com"
  display_name = "key-app-dev"
  algorithm = "AES"
  length = 32
  protection_mode = "HSM"
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
| `management_endpoint` | `string` | Yes | Vault management endpoint. |
| `display_name` | `string` | Yes | Key display name. |
| `algorithm` | `string` | No | Key algorithm. |
| `length` | `number` | No | Key length in bits for symmetric keys. |
| `curve_id` | `string` | No | Curve ID for asymmetric EC keys. |
| `protection_mode` | `string` | No | Key protection mode. |
| `is_auto_rotation_enabled` | `bool` | No | Whether automatic key rotation is enabled. |
| `rotation_interval_in_days` | `number` | No | Automatic key rotation interval in days. |
| `time_of_schedule_start` | `string` | No | Optional RFC3339 timestamp for automatic key rotation schedule start. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | KMS key OCID. |
| `display_name` | KMS key display name. |
| `current_key_version` | Current key version. |

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
.\test.ps1 modules\kms_key\main.tf
```
