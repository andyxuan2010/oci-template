# OCI Block Volume Module

Creates an OCI block volume, optionally assigns a backup policy, and optionally attaches it to a compute instance.

## Usage

Use this for persistent data disks that should outlive compute instance lifecycle.

```hcl
module "block_volume" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/block_volume"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name = "vol-app-dev-001"
  size_in_gbs = 100
  vpus_per_gb = 10
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
| `availability_domain` | `string` | Yes | Availability domain for the block volume. |
| `display_name` | `string` | Yes | Block volume display name. |
| `size_in_gbs` | `number` | No | Block volume size in GB. |
| `vpus_per_gb` | `number` | No | Volume performance units per GB. |
| `backup_policy_id` | `string` | No | Optional volume backup policy OCID. |
| `kms_key_id` | `string` | No | Optional Vault key OCID for volume encryption. |
| `attach_to_instance_id` | `string` | No | Optional compute instance OCID to attach this volume to. |
| `attachment_type` | `string` | No | Volume attachment type. |
| `is_read_only` | `bool` | No | Whether the optional attachment is read-only. |
| `is_shareable` | `bool` | No | Whether the optional attachment is shareable. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Block volume OCID. |
| `display_name` | Block volume display name. |
| `attachment_id` | Volume attachment OCID when enabled. |

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
.\test.ps1 modules\block_volume\main.tf
```
