# dns_record

Manages an entire DNS record set in an existing public or private OCI DNS zone.

## Usage

```hcl
module "dns_record" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dns_record"

  zone_id = "ocid1.dns-zone.oc1..exampleuniqueid"
  domain  = "app.internal.example.com"
  rtype   = "A"
  records = ["10.20.1.10", "10.20.1.11"]
}
```

## Security and Operations

Connect `zone_id` to the existing `dns_zone` module output. The module looks up the zone using the requested scope before creating records, and requires permission to read that zone. The RRSet scope is inferred from the resolved zone ID; it does not use the deprecated RRSet `scope` argument. One module call owns every value for a zone/domain/type tuple; import an existing RRSet before managing it. For a public zone set `scope = "GLOBAL"`. Private zone resolver/view associations remain with the DNS/network owner. OCI RRSets do not support tags.

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
| [oci_dns_rrset.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/dns_rrset) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | Fully qualified record name. | `string` | n/a | yes |
| records | RDATA values in DNS presentation format. | `list(string)` | n/a | yes |
| rtype | DNS record type, for example A or CNAME. | `string` | n/a | yes |
| scope | DNS zone lookup scope; must match the existing zone. | `string` | `"PRIVATE"` | no |
| ttl | TTL in whole seconds. | `number` | `300` | no |
| zone\_id | DNS zone OCID; prefer an OCID over a zone name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| domain | Record domain name. |
| id | DNS record set resource ID. |
| rtype | Record type. |
<!-- END_TF_DOCS -->
