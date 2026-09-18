# OCI Dynamic Group Module

Creates an OCI dynamic group from an explicit matching rule.

## Usage

Use this with IAM policies to grant permissions to resource principals or instance principals.

```hcl
module "dynamic_group" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/dynamic_group"

  compartment_id = "ocid1.tenancy.oc1..exampleuniqueid"
  name = "dg-app-dev"
  description = "Dynamic group for app dev instances"
  matching_rule = "ALL {instance.compartment.id = 'ocid1.compartment.oc1..exampleuniqueid'}"
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Tenancy OCID where the dynamic group is created. |
| `name` | `string` | Yes | Dynamic group name. |
| `description` | `string` | Yes | Dynamic group description. |
| `matching_rule` | `string` | Yes | OCI dynamic group matching rule. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Dynamic group OCID. |
| `name` | Dynamic group name. |
| `matching_rule` | Dynamic group matching rule. |

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
.\test.ps1 modules\dynamic_group\main.tf
```
