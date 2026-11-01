# route_table

Creates an OCI route table and optional internet or NAT gateways.

## Usage

```hcl
module "route_table" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/route_table"

  compartment_id     = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id             = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name       = "rt-app-dev"
  enable_nat_gateway = true
  route_rules = [
    {
      destination    = "0.0.0.0/0"
      network_entity = "nat_gateway"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

NAT and internet gateways are optional and disabled by default in this module. A symbolic gateway reference requires that gateway to be enabled. Use service gateways for private OCI service access where supported; destination rules and outbound access remain caller-owned.

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
| [oci_core_internet_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_nat_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_nat_gateway) | resource |
| [oci_core_route_table.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_route_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Route table display name. | `string` | n/a | yes |
| enable\_internet\_gateway | Create an internet gateway. | `bool` | `false` | no |
| enable\_nat\_gateway | Create a NAT gateway. | `bool` | `false` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| route\_rules | Route rules. Use network\_entity values internet\_gateway, nat\_gateway, or an OCID. | <pre>list(object({<br>    destination      = string<br>    destination_type = optional(string, "CIDR_BLOCK")<br>    network_entity   = string<br>    description      = optional(string)<br>  }))</pre> | `[]` | no |
| vcn\_id | VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Route table OCID. |
| internet\_gateway\_id | Internet gateway OCID when enabled. |
| nat\_gateway\_id | NAT gateway OCID when enabled. |
<!-- END_TF_DOCS -->
