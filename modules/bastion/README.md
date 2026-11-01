# bastion

Creates an OCI Bastion endpoint for controlled access to private targets.

## Usage

```hcl
module "bastion" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/bastion"

  compartment_id   = var.compartment_id
  target_subnet_id = module.subnet.ids["private"]
  name             = "bastion-platform-dev"
  client_cidr_block_allow_list = [
    "203.0.113.10/32"
  ]
  max_session_ttl_in_seconds = 3600
}
```

## Security and Operations

STANDARD Bastions require at least one valid client CIDR narrower than /0. Use individual administrator addresses or narrow corporate ranges, short session lifetimes, and separate IAM authorization. INTERNAL settings are optional and must match the target service capabilities.

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
| [oci_bastion_bastion.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/bastion_bastion) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bastion\_type | Bastion type, normally STANDARD or INTERNAL. | `string` | `"STANDARD"` | no |
| client\_cidr\_block\_allow\_list | CIDR blocks allowed to create sessions through a standard bastion. | `list(string)` | `[]` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| dns\_proxy\_status | DNS proxy status for an internal bastion. | `string` | `null` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| max\_session\_ttl\_in\_seconds | Maximum lifetime of a bastion session. | `number` | `10800` | no |
| name | Bastion name. | `string` | n/a | yes |
| static\_jump\_host\_ip\_addresses | Static jump-host IP addresses for an internal bastion. | `list(string)` | `null` | no |
| target\_subnet\_id | OCID of the subnet containing private targets. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Bastion OCID. |
| private\_endpoint\_ip\_address | Private endpoint IP address assigned to the bastion. |
| state | Bastion lifecycle state. |
<!-- END_TF_DOCS -->
