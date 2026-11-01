# OCI Module Authoring Standard

Each reusable module contains `versions.tf`, `variables.tf`, `main.tf`, `outputs.tf`, `README.md`, `EXAMPLES.md`, and `tests/basic.tftest.hcl`. Use `locals.tf` for readable derived conditions. Preserve public input names and resource addresses unless migration instructions accompany the change.

## Contracts

Modules require Terraform >= 1.7.0 and OCI provider >= 8.23.0, < 9.0.0. The root requires Terraform >= 1.12.0. Authentication belongs in the caller, not child modules. Keep typed object defaults in `variables.tf`; access known attributes directly instead of wrapping them in redundant `try` expressions. Use `try` only where values can legitimately be absent or invalid during a guarded check.

Declare nullability explicitly: required inputs and non-null defaults are non-nullable; optional nullable values default to null. Use maps with stable keys for new repeated resources. Preserve existing list-index addresses in NSG rules rather than silently converting deployed state to different keys.

Validate service enums, CIDRs, port bounds, required source/image values, and cross-input relationships at the appropriate variable or resource boundary. Terraform 1.7 module variable validations must reference only their own variable; use resource preconditions for cross-input rules. Root validations may use cross-variable checks under its newer requirement.

## Security and Naming

Use explicit OCIDs for externally owned resources. Default network endpoints to private where supported, avoid unrestricted administration rules and implicit NFS exports, and make compatibility exceptions explicit. Mark credential values and bootstrap content sensitive; never output secret values. Sensitive values still exist in state.

Accept caller-owned `freeform_tags` and `defined_tags` only on resources that support them. Do not generate hidden IAM permissions, provider credentials, names, or tags inside leaf modules. See [naming](NAMING_CONVENTION.md), [tagging](TAGGING_STANDARD.md), and [security](../SECURITY.md).

## Documentation and Tests

Keep purpose, usage, migration impact, and operational scope human-authored. Generate reference tables with `scripts/Update-ModuleDocs.ps1` using terraform-docs 0.16.0; `-Check` fails on drift. Examples use the canonical `CCOE-Azure/oci-template` source and illustrative identifiers. Pin reviewed refs in production callers.

Mock-provider tests must use `command = plan`. Add assertions for material defaults and negative runs for meaningful security/configuration boundaries. Do not treat mock plans as proof of live service availability or IAM correctness. Run the [contribution checks](../CONTRIBUTING.md) and update the [change record](../CHANGELOG.md) with material behavior changes.
