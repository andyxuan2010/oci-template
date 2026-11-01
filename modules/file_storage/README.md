# file_storage

Creates an OCI File Storage file system, mount target, and NFS export.

## Usage

```hcl
module "file_storage" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/file_storage"

  compartment_id            = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain       = "Uocm:US-ASHBURN-AD-1"
  file_system_display_name  = "fss-app-dev"
  mount_target_display_name = "mt-app-dev"
  subnet_id                 = "ocid1.subnet.oc1.iad.exampleuniqueid"
  hostname_label            = "fssappdev"
  nsg_ids                   = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  export_path               = "/appdev"
  export_options = [
    {
      source = "10.20.0.0/16"
      access = "READ_WRITE"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

At least one explicit client CIDR narrower than /0 is required; omitted/empty export rules are rejected. Defaults squash root, require privileged client ports, and disable anonymous access. Existing clients may need mount or identity changes. Mount targets are private; restrict NSGs and select NFS authentication/encryption appropriate to the workload. Customer-managed at-rest keys are optional.

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
| [oci_file_storage_export.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_export) | resource |
| [oci_file_storage_file_system.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_file_system) | resource |
| [oci_file_storage_mount_target.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/file_storage_mount_target) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_domain | Availability domain for the file system and mount target. | `string` | n/a | yes |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| export\_options | Explicit NFS client rules; at least one restricted source is required. | <pre>list(object({<br>    source                         = string<br>    access                         = optional(string, "READ_WRITE")<br>    identity_squash                = optional(string, "ROOT")<br>    anonymous_gid                  = optional(number)<br>    anonymous_uid                  = optional(number)<br>    allowed_auth                   = optional(list(string))<br>    is_anonymous_access_allowed    = optional(bool, false)<br>    require_privileged_source_port = optional(bool, true)<br>  }))</pre> | `[]` | no |
| export\_path | NFS export path. | `string` | `"/export"` | no |
| file\_system\_display\_name | File system display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| hostname\_label | Optional hostname label for the mount target. | `string` | `null` | no |
| kms\_key\_id | Optional Vault key OCID for file system encryption. | `string` | `null` | no |
| mount\_target\_display\_name | Mount target display name. | `string` | n/a | yes |
| nsg\_ids | NSG OCIDs attached to the mount target. | `list(string)` | `[]` | no |
| subnet\_id | Subnet OCID for the mount target. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| export\_id | Export OCID. |
| export\_path | NFS export path. |
| file\_system\_id | File system OCID. |
| mount\_target\_id | Mount target OCID. |
| mount\_target\_ip\_address | Mount target IP address. |
<!-- END_TF_DOCS -->
