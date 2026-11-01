# notification_topic

Creates an OCI Notifications topic and optional subscriptions.

## Usage

```hcl
module "notification_topic" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/notification_topic"

  compartment_id = var.compartment_id
  name           = "topic-platform-dev"
  description    = "Landing-zone operational notifications"

  subscriptions = {
    platform_email = {
      protocol = "EMAIL"
      endpoint = "platform@example.com"
    }
  }
}
```

## Security and Operations

Grant publish/subscribe IAM separately. Email subscriptions require recipient confirmation. Avoid putting credentials or confidential payloads in notification endpoints or message bodies.

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
| [oci_ons_notification_topic.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_notification_topic) | resource |
| [oci_ons_subscription.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Notification topic description. | `string` | `null` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| name | Notification topic name. | `string` | n/a | yes |
| subscriptions | Subscriptions keyed by a stable Terraform name. Email subscriptions require recipient confirmation. | <pre>map(object({<br>    protocol = string<br>    endpoint = string<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Notification topic OCID. |
| subscription\_ids | Subscription OCIDs keyed by subscription name. |
| topic\_id | Notification topic OCID for alarm destinations. |
<!-- END_TF_DOCS -->
