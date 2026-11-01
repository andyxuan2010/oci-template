# vcn

Creates an OCI Virtual Cloud Network.

## Usage

```hcl
module "vcn" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/vcn"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "vcn-app-dev"
  cidr_blocks    = ["10.20.0.0/16"]
  dns_label      = "appdev"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Use non-overlapping IPv4 CIDRs. The VCN default security list is exposed for compatibility, but the root baseline uses a separate empty security list. Workload access is granted through NSGs.

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
| [oci_core_vcn.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cidr\_blocks | IPv4 CIDR blocks assigned to the VCN. | `list(string)` | n/a | yes |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | VCN display name. | `string` | n/a | yes |
| dns\_label | DNS label for the VCN. Must be unique in the compartment. | `string` | `null` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cidr\_blocks | VCN CIDR blocks. |
| default\_route\_table\_id | Default VCN route table OCID. |
| default\_security\_list\_id | Default VCN security list OCID. |
| id | VCN OCID. |
<!-- END_TF_DOCS -->
