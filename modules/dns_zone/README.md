# OCI Dns Zone Module

Creates a public or private OCI DNS zone.

## Usage

Use this for public DNS or with a private view for internal DNS designs.

```hcl
module "dns_zone" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/dns_zone"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name = "example.internal"
  zone_type = "PRIMARY"
  scope = "GLOBAL"
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
| `name` | `string` | Yes | DNS zone name. |
| `zone_type` | `string` | No | DNS zone type, such as PRIMARY. |
| `scope` | `string` | No | DNS scope. Use GLOBAL for public DNS or PRIVATE for private DNS. |
| `view_id` | `string` | No | Private DNS view OCID when scope is PRIVATE. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | DNS zone OCID. |
| `name` | DNS zone name. |
| `nameservers` | Zone nameservers. |

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
.\test.ps1 modules\dns_zone\main.tf
```
