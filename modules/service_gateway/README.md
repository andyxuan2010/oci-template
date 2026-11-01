# service_gateway

Creates an OCI service gateway for private VCN access to supported OCI services.

## Usage

```hcl
module "service_gateway" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/service_gateway"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "sgw-app-dev"
  services = [
    {
      service_id = "ocid1.service.oc1.iad.exampleuniqueid"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Select OCI service IDs offered in the target region. Service gateways do not install subnet routes automatically; connect the gateway output to route rules and apply appropriate network controls.

Authentication is supplied by the calling configuration; this module declares no provider credentials. Taggable resources accept caller-owned `freeform_tags` and `defined_tags`. See [EXAMPLES.md](EXAMPLES.md), the [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).

## Validation

From this module directory:

```powershell
terraform init -backend=false
terraform validate
terraform test
```

[tests/basic.tftest.hcl](tests/basic.tftest.hcl) runs mock-provider plans without OCI credentials or creating resources. Live service availability, permissions, quotas, and network connectivity require a target-tenancy plan.

## Generated Reference

The tables below are generated from Terraform using `scripts/Update-ModuleDocs.ps1`; do not edit them manually.

## Testing

Run the module tests from this directory:

```sh
terraform init -backend=false
terraform test
```

The test files are in [tests](tests).

## Examples

- [Basic](examples/basic): minimal configuration.
- [Complete](examples/complete): every optional input set.

## Providers

| Name | Source | Version |
| --- | --- | --- |
| oci | oracle/oci | >= 8.23.0, < 9.0.0 |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7.0 |
| oci | >= 8.23.0, < 9.0.0 |

## Resources

| Name | Type |
|------|------|
| [oci_core_service_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_service_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Service gateway display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| route\_table\_id | Optional route table OCID associated with the service gateway. | `string` | `null` | no |
| services | OCI service OCIDs to enable on the service gateway. | <pre>list(object({<br>    service_id = string<br>  }))</pre> | n/a | yes |
| vcn\_id | VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | Service gateway display name. |
| id | Service gateway OCID. |
<!-- END_TF_DOCS -->
