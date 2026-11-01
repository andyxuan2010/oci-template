# network_security_group

Creates an OCI network security group and ingress or egress rules.

## Usage

```hcl
module "network_security_group" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/network_security_group"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "nsg-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source   = "10.20.0.0/16"
      tcp_options = {
        min = 22
        max = 22
      }
    }
  ]
  egress_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Ingress and egress default to empty lists. IPv4/IPv6 /0 ingress to SSH, RDP, WinRM, unrestricted TCP/UDP management ranges, or all protocols is rejected unless `allow_unrestricted_management_ingress = true`. This exception is a risk acceptance setting, not an IAM approval. Public HTTPS rules remain supported. Rule list order determines existing Terraform addresses; preserve it when changing rules.

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
| [oci_core_network_security_group.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.egress](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_network_security_group_security_rule.ingress](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_unrestricted\_management\_ingress | Explicit exception permitting world-accessible management ports or all-protocol ingress. Prefer restricted client CIDRs. | `bool` | `false` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | NSG display name. | `string` | n/a | yes |
| egress\_rules | Egress NSG security rules. | <pre>list(object({<br>    protocol         = string<br>    destination      = string<br>    destination_type = optional(string, "CIDR_BLOCK")<br>    stateless        = optional(bool, false)<br>    description      = optional(string)<br>    tcp_options      = optional(object({ min = number, max = number }))<br>    udp_options      = optional(object({ min = number, max = number }))<br>    icmp_options = optional(object({<br>      type = number<br>      code = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| ingress\_rules | Ingress NSG security rules. | <pre>list(object({<br>    protocol    = string<br>    source      = string<br>    source_type = optional(string, "CIDR_BLOCK")<br>    stateless   = optional(bool, false)<br>    description = optional(string)<br>    tcp_options = optional(object({ min = number, max = number }))<br>    udp_options = optional(object({ min = number, max = number }))<br>    icmp_options = optional(object({<br>      type = number<br>      code = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| vcn\_id | VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | NSG display name. |
| id | NSG OCID. |
<!-- END_TF_DOCS -->
