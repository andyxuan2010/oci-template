# functions

Creates an OCI Functions application and optional container-image functions in caller-selected subnets.

## Usage

```hcl
module "functions" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/functions"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "fnapp-app-dev"
  subnet_ids     = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  functions = {
    worker = { image = "iad.ocir.io/exampletenancy/platform/worker:1.0.0" }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Build and push compatible function images to `container_repository` before deploying functions. Select private subnets with access to OCI Registry through appropriate service/NAT gateways. Configure IAM for image pulls and invocation separately. The module cannot verify whether a supplied subnet is private. Fetch secrets at runtime through resource principals and `vault_secret`; environment configuration is stored in state and must not contain secrets.

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
| [oci_functions_application.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_application) | resource |
| [oci_functions_function.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/functions_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| config | Non-secret application environment configuration. | `map(string)` | `{}` | no |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Functions application display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| functions | Container-image functions keyed by function display name. | <pre>map(object({<br>    image              = string<br>    memory_in_mbs      = optional(number, 256)<br>    timeout_in_seconds = optional(number, 30)<br>    config             = optional(map(string), {})<br>  }))</pre> | `{}` | no |
| network\_security\_group\_ids | Application NSG OCIDs. | `list(string)` | `[]` | no |
| subnet\_ids | Private subnet OCIDs for the application. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| function\_ids | Function OCIDs keyed by function name. |
| id | Functions application OCID. |
| invoke\_endpoints | Function invocation URLs keyed by function name. |
<!-- END_TF_DOCS -->
