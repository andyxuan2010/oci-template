# OCI Iam Policy Module

Creates an OCI IAM policy from explicit policy statements.

## Usage

Use this to make workload authorization explicit and reviewable.

```hcl
module "iam_policy" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/iam_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name = "policy-app-dev"
  description = "Allow app operators to inspect instances"
  statements = ["Allow group app-operators to inspect instances in compartment cmp-app-dev"]
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Compartment OCID where the policy is created. |
| `name` | `string` | Yes | Policy name. |
| `description` | `string` | Yes | Policy description. |
| `statements` | `list(string)` | Yes | OCI IAM policy statements. |
| `version_date` | `string` | No | Optional policy language version date. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Policy OCID. |
| `name` | Policy name. |
| `statements` | Policy statements. |

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
.\test.ps1 modules\iam_policy\main.tf
```
