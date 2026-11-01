# dns_zone

Creates a public or private OCI DNS zone.

## Usage

```hcl
module "dns_zone" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dns_zone"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name           = "example.internal"
  zone_type      = "PRIMARY"
  scope          = "PRIVATE"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Zones now default to `PRIVATE`; use `scope = "GLOBAL"` explicitly for public DNS. Changing scope on an existing zone may require replacement. Supply the appropriate private view and resolver associations for the network design. Use `dns_record` to manage individual record sets.

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
| [oci_dns_zone.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| name | DNS zone name. | `string` | n/a | yes |
| scope | DNS scope. Use GLOBAL for public DNS or PRIVATE for private DNS. | `string` | `"PRIVATE"` | no |
| view\_id | Private DNS view OCID when scope is PRIVATE. | `string` | `null` | no |
| zone\_type | DNS zone type, such as PRIMARY. | `string` | `"PRIMARY"` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | DNS zone OCID. |
| name | DNS zone name. |
| nameservers | Zone nameservers. |
<!-- END_TF_DOCS -->
