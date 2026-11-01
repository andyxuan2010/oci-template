# drg

Creates an OCI Dynamic Routing Gateway and optional VCN attachments.

## Usage

```hcl
module "drg" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/drg"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "drg-app-dev"
  vcn_attachments = {
    spoke = {
      vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Treat VCN attachments and DRG routing as separate ownership decisions. Review hub, on-premises, and cross-VCN reachability before attaching networks. Explicit OCIDs identify resources owned outside this module.

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
| [oci_core_drg.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg) | resource |
| [oci_core_drg_attachment.vcn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_drg_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | DRG display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| vcn\_attachments | Optional VCN attachments keyed by logical attachment name. | <pre>map(object({<br>    vcn_id                           = string<br>    display_name                     = optional(string)<br>    drg_route_table_id               = optional(string)<br>    route_table_id                   = optional(string)<br>    export_drg_route_distribution_id = optional(string)<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | DRG display name. |
| id | DRG OCID. |
| vcn\_attachment\_ids | DRG VCN attachment OCIDs keyed by logical attachment name. |
<!-- END_TF_DOCS -->
