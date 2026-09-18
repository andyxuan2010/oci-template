# OCI Route Table Module

Creates an OCI route table and optional internet or NAT gateways.

## Usage

Use this to own subnet routing explicitly, especially for private egress.

```hcl
module "route_table" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/route_table"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "rt-app-dev"
  enable_nat_gateway = true
  route_rules = [
    {
      destination = "0.0.0.0/0"
      network_entity = "nat_gateway"
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
| `display_name` | `string` | Yes | Route table display name. |
| `enable_internet_gateway` | `bool` | No | Create an internet gateway. |
| `enable_nat_gateway` | `bool` | No | Create a NAT gateway. |
| `route_rules` | `complex` | No | Route rules. Use network_entity values internet_gateway, nat_gateway, or an OCID. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Route table OCID. |
| `internet_gateway_id` | Internet gateway OCID when enabled. |
| `nat_gateway_id` | NAT gateway OCID when enabled. |

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
.\test.ps1 modules\route_table\main.tf
```
