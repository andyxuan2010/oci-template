# subnet

Creates one or more OCI subnets inside a VCN.

## Usage

```hcl
module "subnet" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/subnet"

  compartment_id         = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id                 = "ocid1.vcn.oc1.iad.exampleuniqueid"
  default_route_table_id = "ocid1.routetable.oc1.iad.exampleuniqueid"
  subnets = {
    app = {
      cidr_block                 = "10.20.1.0/24"
      dns_label                  = "app"
      prohibit_public_ip_on_vnic = true
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Subnets are private by default. Set security-list and route-table ownership explicitly. `security_list_ids` output reports the applied lists. The nested `nsg_ids` input is retained only for compatibility and has no effect: attach NSGs to compute VNICs, mount targets, gateways, or load balancers instead.

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
| [oci_core_subnet.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| default\_route\_table\_id | Default route table OCID used when a subnet does not specify route\_table\_id. | `string` | `null` | no |
| default\_security\_list\_ids | Default security-list OCIDs applied to each subnet unless overridden. | `list(string)` | `[]` | no |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| subnets | Subnet definitions keyed by logical subnet name. | <pre>map(object({<br>    cidr_block                 = string<br>    dns_label                  = optional(string)<br>    prohibit_public_ip_on_vnic = optional(bool, true)<br>    security_list_ids          = optional(list(string), [])<br>    route_table_id             = optional(string)<br>    nsg_ids                    = optional(list(string), []) # Deprecated compatibility field; NSGs attach to VNICs, not subnets.<br>  }))</pre> | n/a | yes |
| vcn\_id | VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cidr\_blocks | Subnet CIDR blocks keyed by logical subnet name. |
| ids | Subnet OCIDs keyed by logical subnet name. |
| security\_list\_ids | Applied security-list OCIDs keyed by logical subnet name. |
<!-- END_TF_DOCS -->
