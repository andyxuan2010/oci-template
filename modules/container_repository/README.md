# container_repository

Creates an OCI Container Registry repository with private access and immutable image tags by default.

## Usage

```hcl
module "container_repository" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/container_repository"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "platform/app"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Build and push images separately using OCI Registry authentication. Grant pull permissions to OKE nodes and Functions through narrow IAM policies; this module does not create credentials or build images.

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
| [oci_artifacts_container_repository.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/artifacts_container_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Repository name, including any namespace path. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_immutable | Prevent overwriting existing image tags. | `bool` | `true` | no |
| is\_public | Allow unauthenticated image pulls. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | Repository name. |
| id | Repository OCID. |
| namespace | Registry tenancy namespace. |
<!-- END_TF_DOCS -->
