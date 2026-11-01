# security_list

Creates an OCI security list and optional ingress or egress rules.

## Usage

```hcl
module "security_list" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/security_list"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "sl-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source   = "10.20.0.0/16"
      tcp_options = {
        min = 2049
        max = 2049
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

Ingress and egress default to empty lists. World-accessible SSH/RDP/WinRM and all-protocol ingress require `allow_unrestricted_management_ingress = true`. Prefer NSGs for workload rules. The root uses an empty instance of this module to avoid inheriting OCI default-list rules.

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
| [oci_core_security_list.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_security_list) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_unrestricted\_management\_ingress | Explicit exception permitting world-accessible management ports or all-protocol ingress. Prefer restricted client CIDRs. | `bool` | `false` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Security list display name. | `string` | n/a | yes |
| egress\_rules | Egress security list rules. | <pre>list(object({<br>    protocol         = string<br>    destination      = string<br>    destination_type = optional(string, "CIDR_BLOCK")<br>    stateless        = optional(bool, false)<br>    description      = optional(string)<br>    tcp_options      = optional(object({ min = number, max = number }))<br>    udp_options      = optional(object({ min = number, max = number }))<br>    icmp_options = optional(object({<br>      type = number<br>      code = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| ingress\_rules | Ingress security list rules. | <pre>list(object({<br>    protocol    = string<br>    source      = string<br>    source_type = optional(string, "CIDR_BLOCK")<br>    stateless   = optional(bool, false)<br>    description = optional(string)<br>    tcp_options = optional(object({ min = number, max = number }))<br>    udp_options = optional(object({ min = number, max = number }))<br>    icmp_options = optional(object({<br>      type = number<br>      code = optional(number)<br>    }))<br>  }))</pre> | `[]` | no |
| vcn\_id | VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | Security list display name. |
| id | Security list OCID. |
<!-- END_TF_DOCS -->
