# OCI Compartment Module

Creates a child OCI compartment for workload isolation.

## Usage

Use this when the repo owns the workload compartment lifecycle.

```hcl
module "compartment" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/compartment"

  parent_compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name = "cmp-app-dev"
  description = "Compartment for app dev resources"
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `parent_compartment_id` | `string` | Yes | Parent compartment or tenancy OCID. |
| `name` | `string` | Yes | Compartment name. |
| `description` | `string` | Yes | Compartment description. |
| `enable_delete` | `bool` | No | Allow Terraform destroy to delete the compartment. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Compartment OCID. |
| `name` | Compartment name. |

## Examples

See [EXAMPLES.md](./EXAMPLES.md) for a complete example.

## Terraform Tests

This module includes a mock-provider plan test at [tests/basic.tftest.hcl](./tests/basic.tftest.hcl). Run it from the module directory:

```powershell
terraform init -backend=false
terraform test
```

The repository-level validation helper also validates module syntax:

```powershell
.\test.ps1 modules\compartment\main.tf
```
