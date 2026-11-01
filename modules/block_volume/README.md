# block_volume

Creates an OCI block volume, optionally assigns a backup policy, and optionally attaches it to a compute instance.

## Usage

```hcl
module "block_volume" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/block_volume"

  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name        = "vol-app-dev-001"
  size_in_gbs         = 100
  vpus_per_gb         = 10
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Paravirtualized attachments enable encryption in transit by default and require compatible instances. The flag is omitted for iSCSI/NVMe; iSCSI authentication and transport security require a separate design. Use a backup policy and a customer-managed key when required. Manage each backup assignment through this module or `volume_backup_policy`, never both.

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
| [oci_core_volume.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume) | resource |
| [oci_core_volume_attachment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_attachment) | resource |
| [oci_core_volume_backup_policy_assignment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_volume_backup_policy_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attach\_to\_instance\_id | Optional compute instance OCID to attach this volume to. | `string` | `null` | no |
| attachment\_type | Volume attachment type. | `string` | `"paravirtualized"` | no |
| availability\_domain | Availability domain for the block volume. | `string` | n/a | yes |
| backup\_policy\_id | Optional volume backup policy OCID. | `string` | `null` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Block volume display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_pv\_encryption\_in\_transit\_enabled | Encrypt traffic on paravirtualized attachments; not applied to iSCSI or NVMe. | `bool` | `true` | no |
| is\_read\_only | Whether the optional attachment is read-only. | `bool` | `false` | no |
| is\_shareable | Whether the optional attachment is shareable. | `bool` | `false` | no |
| kms\_key\_id | Optional Vault key OCID for volume encryption. | `string` | `null` | no |
| size\_in\_gbs | Block volume size in GB. | `number` | `50` | no |
| vpus\_per\_gb | Volume performance units per GB. | `number` | `10` | no |

## Outputs

| Name | Description |
|------|-------------|
| attachment\_id | Volume attachment OCID when enabled. |
| display\_name | Block volume display name. |
| id | Block volume OCID. |
<!-- END_TF_DOCS -->
