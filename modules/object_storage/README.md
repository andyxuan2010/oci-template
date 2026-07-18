# OCI Object Storage Module

Creates an OCI Object Storage bucket with private access and versioning enabled by default.

## Usage

Use this for workload artifacts, logs, backups, or Terraform remote-state bootstrap buckets.

```hcl
module "object_storage" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/object_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  namespace = "exampletenancy"
  name = "bucket-app-dev"
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
| `namespace` | `string` | Yes | Object Storage namespace. |
| `name` | `string` | Yes | Bucket name. |
| `access_type` | `string` | No | Bucket access type. |
| `storage_tier` | `string` | No | Bucket storage tier. |
| `versioning` | `string` | No | Bucket object versioning: Enabled or Disabled. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Bucket resource ID. |
| `name` | Bucket name. |
| `namespace` | Bucket namespace. |

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
.\test.ps1 modules\object_storage\main.tf
```
