# Change Record

## 2026-10-29 — Standardization and Security Hardening

Implementation commit: [32067f7](https://github.com/CCOE-Azure/oci-template/commit/32067f77def3ed44ef6d21279dabcd3a532bf4b8).

- Reviewed the complete 36-module library, root, automation, and documentation renderer.
- Standardized OCI provider constraints, Terraform requirements, input nullability, typed defaults, line endings, generated module references, source URLs, and examples.
- Added IMDSv2/transport encryption defaults, restricted explicit NFS exports, management-ingress guards, a root-owned empty security list, a private DNS zone default, TLS protocol/certificate controls, and targeted input validation.
- Added bucket KMS/event inputs, protected bootstrap content, fixed provider-profile selection, and documented remaining workload-owned IAM, encryption, authentication, backup, and retention choices.
- Replaced committed environment inputs with an illustrative sample and made backend location explicit. CI now supplies provider credentials from protected inputs, pins actions/tool versions, verifies docs-tool downloads, limits plan artifact lifetime, removes temporary credentials, and checks documentation drift.
- Hardened helper failure handling and documentation URL/output-path handling. Added security regression plans and documentation security checks.
- Refreshed every module README and example, repository guides, coverage/dependency documentation, migration/operations/security guidance, and validation evidence.
- Preserved the original checkout's unrelated uncommitted documentation edits by working in the isolated sibling worktree. No live OCI deployment or state migration was performed.
- Validation passed 93 mock plan runs, all 36 module validations, TFLint, generated-reference checks, documentation security/link checks, workflow/preflight checks, and the 88-page local site build. GitHub Actions could not start jobs because of account billing/spending limits; see [validation evidence](docs/VALIDATION_SUMMARY.md).

## 2026-10-29 — Ten Common Platform Modules

Commit: [933c3a2](https://github.com/CCOE-Azure/oci-template/commit/933c3a23731dadbe587d6597fabc91d3f36c0ea4).

Added `oke`, `container_repository`, `autonomous_database`, `vault_secret`, `api_gateway`, `functions`, `queue`, `events_rule`, `volume_backup_policy`, and `dns_record`, increasing the library from 26 to 36 modules. Compared capabilities with sibling Azure/AWS templates, added examples and cross-cloud/dependency documentation, corrected the inventory, and enabled native module plan tests in CI.

Initial validation passed all 36 modules and 54 mock plan runs, plus the documentation build. The additions remain opt-in and do not automatically deploy workload services in the root baseline.
