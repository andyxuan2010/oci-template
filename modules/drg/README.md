# OCI Drg Module

Creates an OCI Dynamic Routing Gateway and optional VCN attachments.

## Usage

Use this for hub, hybrid, FastConnect, VPN, or cross-VCN routing foundations.

```hcl
module "drg" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/drg"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "drg-app-dev"
  vcn_attachments = {
    spoke = {
      vcn_id = "ocid1.vcn.oc1.iad.exampleuniqueid"
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
| `display_name` | `string` | Yes | DRG display name. |
| `vcn_attachments` | `complex` | No | Optional VCN attachments keyed by logical attachment name. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | DRG OCID. |
| `display_name` | DRG display name. |
| `vcn_attachment_ids` | DRG VCN attachment OCIDs keyed by logical attachment name. |

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
.\test.ps1 modules\drg\main.tf
```
