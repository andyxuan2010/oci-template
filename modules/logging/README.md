# logging

Creates an OCI log group and zero or more service/custom logs.

## Usage

```hcl
module "logging" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/logging"

  compartment_id = var.compartment_id
  display_name   = "logs-platform-dev"
  description    = "Landing-zone service logs"

  logs = {
    vcn_flow = {
      display_name       = "vcn-flow-platform-dev"
      retention_duration = 30
      configuration = {
        category = "all"
        resource = module.vcn.id
        service  = "flowlogs"
      }
    }
  }
}
```

## Security and Operations

Enable only service categories offered by the target resource and region. Retention defaults to 30 days for configured logs. Review retention, log-reader IAM, and application redaction because log content can contain sensitive data.

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
| [oci_logging_log.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log) | resource |
| [oci_logging_log_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/logging_log_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Log group description. | `string` | `null` | no |
| display\_name | Log group display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| logs | Service or custom logs keyed by a stable Terraform name. | <pre>map(object({<br>    display_name       = string<br>    log_type           = optional(string, "SERVICE")<br>    is_enabled         = optional(bool, true)<br>    retention_duration = optional(number, 30)<br>    configuration = optional(object({<br>      compartment_id = optional(string)<br>      category       = string<br>      resource       = string<br>      service        = string<br>      source_type    = optional(string, "OCISERVICE")<br>      parameters     = optional(map(string), {})<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| log\_group\_id | Log group OCID. |
| log\_ids | Log OCIDs keyed by log name. |
<!-- END_TF_DOCS -->
