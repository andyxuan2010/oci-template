# events_rule

Routes matching OCI service events to Notifications, Functions, or Streaming destinations.

## Usage

```hcl
module "events_rule" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/events_rule"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "events-storage-dev"
  condition      = jsonencode({ eventType = ["com.oraclecloud.objectstorage.createbucket"] })
  actions = {
    notify = { action_type = "ONS", topic_id = "ocid1.onstopic.oc1.iad.exampleuniqueid" }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Create destination resources first and grant the Events service permission to deliver to them. Conditions use `jsonencode` and provider-supported `condition` for compatibility with OCI provider 8.23. Object-level Object Storage events also require event emission on the source bucket. This module does not route directly to OCI Queue.

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
| [oci_events_rule.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/events_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| actions | Actions keyed by logical name. Each action must have exactly its matching destination. | <pre>map(object({<br>    action_type = string<br>    is_enabled  = optional(bool, true)<br>    description = optional(string)<br>    topic_id    = optional(string)<br>    function_id = optional(string)<br>    stream_id   = optional(string)<br>  }))</pre> | n/a | yes |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| condition | OCI event-matching condition as a JSON object. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Event rule display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_enabled | Enable event routing. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| display\_name | Events rule display name. |
| id | Events rule OCID. |
<!-- END_TF_DOCS -->
