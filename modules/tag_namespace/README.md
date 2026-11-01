# tag_namespace

Creates an OCI defined-tag namespace and optional tag definitions.

## Usage

```hcl
module "governance_tags" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/tag_namespace"

  compartment_id = var.tenancy_ocid
  name           = "Governance"
  description    = "Landing-zone governance tags"

  tags = {
    Environment = {
      description      = "Deployment environment"
      is_cost_tracking = true
      validator = {
        validator_type = "ENUM"
        values         = ["dev", "sandbox", "prod"]
      }
    }
    Owner = {
      description = "Owning team"
    }
  }
}
```

## Security and Operations

Tag namespaces and definitions must exist before callers use defined tags. Validator values and cost-tracking choices are organization policy; review retirement and deletion impacts on existing resources.

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
| [oci_identity_tag.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag) | resource |
| [oci_identity_tag_namespace.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_tag_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Tenancy or compartment OCID that owns the tag namespace. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Tag namespace description. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_retired | Whether the tag namespace is retired. | `bool` | `false` | no |
| name | Tag namespace name. | `string` | n/a | yes |
| tags | Tag definitions keyed by tag name. | <pre>map(object({<br>    description      = string<br>    is_cost_tracking = optional(bool, false)<br>    is_retired       = optional(bool, false)<br>    validator = optional(object({<br>      validator_type = string<br>      values         = list(string)<br>    }))<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Tag namespace OCID. |
| tag\_ids | Tag definition OCIDs keyed by tag name. |
| tag\_names | Tag definition names keyed by tag name. |
<!-- END_TF_DOCS -->
