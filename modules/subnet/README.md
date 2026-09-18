# OCI Subnet Module

Creates one or more OCI subnets inside a VCN.

## Usage

Use private subnets by default; attach route tables and security lists from network foundation modules.

```hcl
module "subnet" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/subnet"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  default_route_table_id = "ocid1.routetable.oc1.iad.exampleuniqueid"
  subnets = {
    app = {
      cidr_block = "10.20.1.0/24"
      dns_label = "app"
      prohibit_public_ip_on_vnic = true
    }
  }
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
| `default_route_table_id` | `string` | No | Default route table OCID used when a subnet does not specify route_table_id. |
| `default_nsg_ids` | `list(string)` | No | Default NSG OCIDs applied to each subnet unless overridden. |
| `subnets` | `complex` | Yes | Subnet definitions keyed by logical subnet name. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `ids` | Subnet OCIDs keyed by logical subnet name. |
| `cidr_blocks` | Subnet CIDR blocks keyed by logical subnet name. |

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
.\test.ps1 modules\subnet\main.tf
```
