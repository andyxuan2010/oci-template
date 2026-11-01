# iam_policy

Creates an OCI IAM policy from explicit policy statements.

## Usage

```hcl
module "iam_policy" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/iam_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name           = "policy-app-dev"
  description    = "Allow app operators to inspect instances"
  statements     = ["Allow group app-operators to inspect instances in compartment cmp-app-dev"]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Security and Operations

Statements must be nonempty. This module does not parse the OCI authorization language or certify least privilege. Review subjects, verbs, resource families, compartment scope, and conditions; avoid tenancy-wide administrative statements for workloads.

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
| [oci_identity_policy.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID where the policy is created. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| description | Policy description. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| name | Policy name. | `string` | n/a | yes |
| statements | OCI IAM policy statements. | `list(string)` | n/a | yes |
| version\_date | Optional policy language version date. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | Policy OCID. |
| name | Policy name. |
| statements | Policy statements. |
<!-- END_TF_DOCS -->
