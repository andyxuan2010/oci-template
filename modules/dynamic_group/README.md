# dynamic_group

Creates an OCI dynamic group from an explicit matching rule.

## Usage

```hcl
module "dynamic_group" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dynamic_group"

  compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name           = "dg-app-dev"
  description    = "Dynamic group for app dev instances"
  matching_rule  = "ALL {instance.compartment.id = 'ocid1.compartment.oc1..exampleuniqueid'}"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Provide a nonempty, narrowly scoped matching rule. A dynamic group grants no permissions by itself; pair it with reviewed IAM statements. Avoid matching every instance or resource in the tenancy.

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
| [oci_identity_dynamic_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_dynamic_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Tenancy OCID where the dynamic group is created. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Dynamic group description. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| matching\_rule | OCI dynamic group matching rule. | `string` | n/a | yes |
| name | Dynamic group name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Dynamic group OCID. |
| matching\_rule | Dynamic group matching rule. |
| name | Dynamic group name. |
<!-- END_TF_DOCS -->
