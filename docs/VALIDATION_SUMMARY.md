# OCI Validation Results

Validation date: 2026-10-29. Scope: the 36-module library, nine-module root baseline, repository helpers, workflows, and documentation.

## Results

| Check | Result |
| --- | --- |
| Terraform root/module/test formatting | Passed |
| Root initialization with backend disabled and root validation | Passed |
| Root mock plan tests | 3 passed, 0 failed |
| Per-module initialization/validation | 36 of 36 passed |
| Module mock plan tests | 90 passed, 0 failed |
| Combined root/module mock plan runs | 93 passed, 0 failed |
| TFLint recursive Terraform checks | No issues or errors |
| Generated README reference check | 36 of 36 current |
| Markdown local-link check | 88 documents, no broken local targets |
| Documentation URL/output-path security tests | Passed |
| Documentation site build/generated-page checks | Passed for 88 documents |
| Workflow YAML and embedded Bash syntax | Passed; all action references are commit-pinned |
| Credential/state/apply preflight scenarios | 3 cases passed |
| PowerShell helper parsing and execution | Passed |
| Complete private-key block check in tracked text | None found |
| Git whitespace check | Passed |
| GitHub-hosted workflow execution | Blocked before jobs started by account billing/spending limits |

Tools used: Terraform 1.15.8, OCI provider 8.23.0, terraform-docs 0.16.0, TFLint 0.46.1, and PowerShell 7 on Windows amd64. Terraform source was copied to a temporary local validation directory and initialized against the already installed provider binary to avoid repeated network-drive copies. Temporary provider/lock artifacts are not committed.

The suite exercises private defaults, IMDSv2 and volume transport encryption, explicit restricted NFS rules and root squash, IPv4/IPv6 management ingress, allowed public HTTPS and explicit exceptions, TLS protocol floors, bucket key/event wiring, DNS scope selection, backup/event/secret wiring, optional child resources, malformed inputs, and root security-list composition. The module helper was also exercised against the initialized local module set; the workflow preflight was run with synthetic values only.

## Reproduce

Follow the complete command sequence in [CONTRIBUTING.md](../CONTRIBUTING.md). Native tests are plan-only with mocked OCI providers and require no OCI credentials. The CI validation job runs the root/module checks, documentation security tests, and generated reference drift check. Pages builds validate the static site.

## Limits

No live OCI plan/apply, remote backend access, state move, or resource migration was performed. Mock tests do not prove tenancy permissions, regional availability, image/shape compatibility, client connectivity, or live service acceptance. TFLint is Terraform linting, not a comprehensive vulnerability scan. The local Checkov launcher could not run successfully, so no Checkov pass or full external policy scan is claimed.

Preserve the existing state location and review a real plan before deploying. Read [migration notes](MIGRATION.md), [hardening findings](HARDENING.md), and [security guidance](../SECURITY.md).

## Remote CI Status

Code commit: [32067f7](https://github.com/CCOE-Azure/oci-template/commit/32067f77def3ed44ef6d21279dabcd3a532bf4b8).

After pushing, both the [Terraform run](https://github.com/CCOE-Azure/oci-template/actions/runs/40906477242) and [documentation run](https://github.com/CCOE-Azure/oci-template/actions/runs/40906477050) failed before their gate jobs executed any steps. GitHub annotations identify failed account payments or an insufficient Actions spending limit. No remote validation, plan, apply, or documentation deployment ran in those workflows.

Local checks above passed. Remote CI remains unverified until the account owner resolves the billing/spending-limit issue and reruns the workflows. This restriction is separate from the explicit OCI state-input configuration required for deployment.
