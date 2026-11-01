# OCI GitHub Actions Pipeline

`.github/workflows/terraform.yml` supports pushes to `main`, `dev`, and `sbx`, pull requests to those branches, manual dispatch, and stage-snapshot dispatch. `IS_ORIGIN` controls the Terraform gate; origin/mirror loop protection and optional snapshot publishing remain in place. Markdown-only pull requests are excluded by the workflow path filter.

## Validation

Validation uses pinned action SHAs and Terraform 1.15.8 with the wrapper disabled. It runs root initialization without backend access, formatting, root validation and mock tests, documentation security tests, generated module reference checks, per-module initialization/validation, and all module mock plan tests. A provider cache avoids repeated provider downloads during module validation. The module runner fails when no tests pass or a command fails.

terraform-docs 0.16.0 is installed from the official release and its archive is checked against a pinned SHA-256 before extraction. Module references are checked with `scripts/Update-ModuleDocs.ps1 -Check`.

## Required Deployment Inputs

| Kind | Name | Purpose |
| --- | --- | --- |
| Variable | `IS_ORIGIN` | Set to `true` to enable the origin Terraform workflow. |
| Variable | `OCI_REGION` | Provider/workload region. |
| Variable | `OCI_STATE_BUCKET` | Existing private, versioned state bucket name. |
| Variable | `OCI_STATE_NAMESPACE` | Existing Object Storage namespace. |
| Variable | `OCI_STATE_KEY` | Exact environment state object key. |
| Optional variable | `OCI_STATE_REGION` | State region, defaulting to `OCI_REGION`. |
| Secret | `OCI_TENANCY_OCID` | Deployment tenancy. |
| Secret | `OCI_USER_OCID` | API-key user. |
| Secret | `OCI_FINGERPRINT` | API signing key fingerprint. |
| Secret | `OCI_PRIVATE_KEY` | Full unencrypted PEM signing key. |

Missing credentials or explicit state location inputs skip plan/apply; they do not silently select local state. Provider values are passed as `TF_VAR_*` inputs during plan. The native backend uses its case-sensitive `OCI_*` names and receives non-secret location values through `-backend-config`. Local `terraform.tfvars` files are ignored and are not part of CI.

PEM content is validated, masked by the secrets mechanism, and written to a temporary file for backend use. The sensitive provider PEM variable uses the same key content. Keys and local saved plans are removed in `always()` cleanup steps. Saved plans contain sensitive information and have one-day artifact retention; limit repository/artifact access accordingly.

## Plan, Apply, and Publishing Gates

Plan is limited to non-PR events with successful validation and complete deployment inputs. State locking is retained with a five-minute lock wait. Apply additionally requires manual dispatch with `apply=true` or `ENABLE_GITHUB_APPLY=true`, and consumes the saved plan artifact. This gate is an explicit deployment authorization mechanism; review repository settings before enabling automatic applies.

Snapshot publishing optionally uses `STAGE_REPOSITORY` and `STAGE_REPO_TOKEN`. It retains the existing clean-snapshot/force-publish behavior for the designated demo destination. Use a destination-specific token and confirm the configured repository. Only the release-tagging job keeps a persisted checkout credential with scoped `contents: write`; other checkout steps do not persist credentials.

The Pages workflow builds and validates the documentation, runs documentation security checks, and follows the existing origin/stage routing. See [operations](OPERATIONS.md) and [migration notes](MIGRATION.md) before changing state location or enabling deployment gates.

## Startup Troubleshooting

If GitHub marks a gate job failed with no steps or logs, inspect its check annotations. The hardening push encountered an account payment/Actions spending-limit restriction before any job executed; resolve that account issue and rerun the workflows before expecting remote validation or publishing results. See [validation evidence](VALIDATION_SUMMARY.md). Missing OCI credentials/state variables produce a different outcome: the preflight runs and deployment jobs are skipped.
