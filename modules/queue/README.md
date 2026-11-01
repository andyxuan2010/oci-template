# queue

Creates an OCI Queue with configurable retention, visibility, dead-letter delivery count, and optional customer-managed encryption.

## Usage

```hcl
module "queue" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/queue"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "queue-app-dev"
  freeform_tags  = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Grant producers and consumers IAM access separately. OCI Queue provides a built-in dead-letter queue; a delivery count of zero disables it. If using a customer-managed key, grant the Queue service the required key permissions. This module does not create consumer applications or private network endpoints.

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
| [oci_queue_queue.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/queue_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| custom\_encryption\_key\_id | Optional symmetric KMS key OCID; otherwise service-managed encryption. | `string` | `null` | no |
| dead\_letter\_queue\_delivery\_count | Delivery attempts before moving to the built-in DLQ; zero disables it. | `number` | `5` | no |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Queue display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| retention\_in\_seconds | Message retention, from 10 to 604800 seconds. | `number` | `345600` | no |
| timeout\_in\_seconds | Long-poll timeout, from 0 to 30 seconds. | `number` | `20` | no |
| visibility\_in\_seconds | Visibility timeout, from 1 to 43200 seconds. | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Queue OCID. |
| messages\_endpoint | Queue messaging endpoint. |
<!-- END_TF_DOCS -->
