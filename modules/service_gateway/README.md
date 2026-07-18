# OCI Service Gateway Module

Creates an OCI service gateway for private VCN access to supported OCI services.

## Usage

Use this with route table rules when private subnets need OCI service access without public internet traversal.

```hcl
module "service_gateway" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/service_gateway"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "sgw-app-dev"
  services = [
    {
      service_id = "ocid1.service.oc1.iad.exampleuniqueid"
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
| `display_name` | `string` | Yes | Service gateway display name. |
| `services` | `complex` | Yes | OCI service OCIDs to enable on the service gateway. |
| `route_table_id` | `string` | No | Optional route table OCID associated with the service gateway. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Service gateway OCID. |
| `display_name` | Service gateway display name. |

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
.\test.ps1 modules\service_gateway\main.tf
```
