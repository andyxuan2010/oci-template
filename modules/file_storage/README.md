# OCI File Storage Module

Creates an OCI File Storage file system, mount target, and NFS export.

## Usage

Use this for shared NFS workloads with private mount targets and explicit export options.

```hcl
module "file_storage" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/file_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  file_system_display_name = "fss-app-dev"
  mount_target_display_name = "mt-app-dev"
  subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  hostname_label = "fssappdev"
  nsg_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  export_path = "/appdev"
  export_options = [
    {
      source = "10.20.0.0/16"
      access = "READ_WRITE"
    }
  ]
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
| `availability_domain` | `string` | Yes | Availability domain for the file system and mount target. |
| `file_system_display_name` | `string` | Yes | File system display name. |
| `mount_target_display_name` | `string` | Yes | Mount target display name. |
| `subnet_id` | `string` | Yes | Subnet OCID for the mount target. |
| `hostname_label` | `string` | No | Optional hostname label for the mount target. |
| `nsg_ids` | `list(string)` | No | NSG OCIDs attached to the mount target. |
| `kms_key_id` | `string` | No | Optional Vault key OCID for file system encryption. |
| `export_path` | `string` | No | NFS export path. |
| `export_options` | `complex` | No | Optional NFS export options. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `file_system_id` | File system OCID. |
| `mount_target_id` | Mount target OCID. |
| `mount_target_ip_address` | Mount target IP address. |
| `export_id` | Export OCID. |
| `export_path` | NFS export path. |

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
.\test.ps1 modules\file_storage\main.tf
```
