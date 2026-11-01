# object_storage

Creates an OCI Object Storage bucket with private access and versioning enabled by default.

## Usage

```hcl
module "object_storage" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/object_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  namespace      = "exampletenancy"
  name           = "bucket-app-dev"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Buckets default to `NoPublicAccess` and enabled versioning. Public access requires an explicit `access_type`; do not use it for state or confidential objects. Optional `kms_key_id` selects a customer-managed key and requires Object Storage key permissions. `object_events_enabled` enables object-level Events integration. Retention rules and deletion protection require workload-specific policy.

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
| [oci_objectstorage_bucket.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/objectstorage_bucket) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_type | Bucket access type. | `string` | `"NoPublicAccess"` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| kms\_key\_id | Optional symmetric KMS key OCID for bucket encryption. | `string` | `null` | no |
| name | Bucket name. | `string` | n/a | yes |
| namespace | Object Storage namespace. | `string` | n/a | yes |
| object\_events\_enabled | Enable object-level event emission for integration with Events rules. | `bool` | `false` | no |
| storage\_tier | Bucket storage tier. | `string` | `"Standard"` | no |
| versioning | Bucket object versioning: Enabled or Disabled. | `string` | `"Enabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Bucket resource ID. |
| name | Bucket name. |
| namespace | Bucket namespace. |
<!-- END_TF_DOCS -->
