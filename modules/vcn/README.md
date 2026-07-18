# OCI Vcn Module

Creates an OCI Virtual Cloud Network.

## Usage

Use this as the network address boundary for workload or platform resources.

```hcl
module "vcn" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/vcn"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "vcn-app-dev"
  cidr_blocks = ["10.20.0.0/16"]
  dns_label = "appdev"
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
| `display_name` | `string` | Yes | VCN display name. |
| `cidr_blocks` | `list(string)` | Yes | IPv4 CIDR blocks assigned to the VCN. |
| `dns_label` | `string` | No | DNS label for the VCN. Must be unique in the compartment. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | VCN OCID. |
| `cidr_blocks` | VCN CIDR blocks. |
| `default_security_list_id` | Default VCN security list OCID. |
| `default_route_table_id` | Default VCN route table OCID. |

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
.\test.ps1 modules\vcn\main.tf
```
