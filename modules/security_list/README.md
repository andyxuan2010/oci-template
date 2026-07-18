# OCI Security List Module

Creates an OCI security list and optional ingress or egress rules.

## Usage

Use security lists for subnet-level defaults; prefer NSGs for app-specific controls.

```hcl
module "security_list" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/security_list"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "sl-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source = "10.20.0.0/16"
      tcp_options = {
        min = 2049
        max = 2049
      }
    }
  ]
  egress_rules = [
    {
      protocol = "all"
      destination = "0.0.0.0/0"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Compartment OCID. |
| `vcn_id` | `string` | Yes | VCN OCID. |
| `display_name` | `string` | Yes | Security list display name. |
| `ingress_rules` | `complex` | No | Ingress security list rules. |
| `egress_rules` | `complex` | No | Egress security list rules. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Security list OCID. |
| `display_name` | Security list display name. |

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
.\test.ps1 modules\security_list\main.tf
```
