# compartment

Creates a child OCI compartment for workload isolation.

## Usage

```hcl
module "compartment" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/compartment"

  parent_compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name                  = "cmp-app-dev"
  description           = "Compartment for app dev resources"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Choose an explicit parent compartment and grant the deployment principal only the permissions it needs. `enable_delete` controls OCI compartment deletion; review destroy plans and child-resource ownership before enabling deletion.

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
| [oci_identity_compartment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Compartment description. | `string` | n/a | yes |
| enable\_delete | Allow Terraform destroy to delete the compartment. | `bool` | `true` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| name | Compartment name. | `string` | n/a | yes |
| parent\_compartment\_id | Parent compartment or tenancy OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Compartment OCID. |
| name | Compartment name. |
<!-- END_TF_DOCS -->
