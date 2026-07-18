# OCI Network Security Group Module

Creates an OCI network security group and ingress or egress rules.

## Usage

Use NSGs for workload-specific VNIC or load balancer network controls.

```hcl
module "network_security_group" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/network_security_group"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name = "nsg-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source = "10.20.0.0/16"
      tcp_options = {
        min = 22
        max = 22
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
| `display_name` | `string` | Yes | NSG display name. |
| `ingress_rules` | `complex` | No | Ingress NSG security rules. |
| `egress_rules` | `complex` | No | Egress NSG security rules. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | NSG OCID. |
| `display_name` | NSG display name. |

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
.\test.ps1 modules\network_security_group\main.tf
```
