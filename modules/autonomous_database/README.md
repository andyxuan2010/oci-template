# autonomous_database

Creates an Autonomous Transaction Processing database with a private endpoint and mutual TLS enabled.

## Usage

```hcl
module "autonomous_database" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/autonomous_database"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "adb-app-dev"
  db_name        = "APPDEV"
  admin_password = var.database_admin_password
  subnet_id      = "ocid1.subnet.oc1.iad.exampleuniqueid"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Declare `database_admin_password` as a sensitive string variable in the caller and supply it from protected CI inputs. The password remains in Terraform state. Provide a private subnet, DNS resolution, and NSG rules for database clients. Choose region-supported ECPU capacity and review licensing and costs before applying. Wallet distribution, database users, schema migrations, and disaster recovery are outside this module.

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
| [oci_database_autonomous_database.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/database_autonomous_database) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_password | ADMIN password meeting OCI password requirements. | `string` | n/a | yes |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| compute\_count | ECPU count. | `number` | `2` | no |
| data\_storage\_size\_in\_tbs | Allocated data storage in TB. | `number` | `1` | no |
| db\_name | Database name: 1-14 alphanumeric characters, starting with a letter. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Database display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_auto\_scaling\_enabled | Enable compute autoscaling. | `bool` | `false` | no |
| license\_model | LICENSE\_INCLUDED or BRING\_YOUR\_OWN\_LICENSE. | `string` | `"LICENSE_INCLUDED"` | no |
| nsg\_ids | NSGs controlling database connectivity. | `list(string)` | `[]` | no |
| subnet\_id | Private endpoint subnet OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| db\_name | Database name. |
| id | Autonomous Database OCID. |
| private\_endpoint | Private endpoint IP address. |
<!-- END_TF_DOCS -->
