# Hardening Review and Implementation

Review date: 2026-10-29. Scope: all 36 reusable modules, root composition, validation helpers, GitHub Actions, documentation generation, and the static documentation renderer.

| Finding | Implemented change | Verification |
| --- | --- | --- |
| Mixed Terraform/provider version contracts and implicit null handling | Unified module constraints and explicit input nullability; retained optional nulls. | Root/module validation and mock plans. |
| Repeated fallback expressions obscured typed object defaults | Removed redundant `try` expressions while preserving resource addresses and optional defaults. | Full module mock plan suite. |
| Compute did not require IMDSv2 or volume transport encryption | Added conservative defaults and caller-visible compatibility inputs; bootstrap content is sensitive. | Metadata, transport, private-VNIC, and invalid-key tests. |
| Implicit/empty NFS exports could inherit broad OCI defaults | Require restricted explicit CIDRs; default ROOT squash, privileged ports, and anonymous access disabled. | Default assertions and empty/world-export rejection tests. |
| Root inherited OCI's default security list | Added a managed empty security list and associated root subnets with it. | Root composition mock test. |
| World-accessible management ingress was unchecked | Added IPv4/IPv6 management guards, explicit exception input, and port-range validation. | SSH/RDP/all-protocol rejection, public HTTPS, and exception tests. |
| Object encryption/event integration was absent from bucket contract | Added optional KMS key and object event inputs with enum validation. | Private/versioned defaults, key/event wiring, invalid access tests. |
| TLS listeners lacked a protocol floor and external certificate IDs | Added TLSv1.2/TLSv1.3 validation and OCI Certificates references; validated backend-set references. | TLS default, legacy TLS rejection, and missing-backend tests. |
| Bastion/DNS/IAM/key-rotation inputs allowed avoidable mistakes | Restricted Bastion client CIDRs, private DNS zone default, nonempty statements/rules, and rotation interval checks. | Targeted positive and negative mock plans. |
| Environment-specific inputs and backend location were committed | Added an illustrative ignored-copy workflow and partial backend; CI requires explicit state location and protected provider inputs. | Workflow configuration checks; no live backend access. |
| Mutable action references, default artifact lifetime, and weak failure handling | Pinned action SHAs/tool versions, checksum-verified docs tooling, one-day plan retention, credential cleanup, and failure propagation. | YAML/PowerShell checks and helper execution. |
| Documentation tables and examples drifted from code | Regenerated all 36 README references, normalized all examples and source URLs, and added a CI drift check. | terraform-docs check, link checks, site build. |
| Docs renderer accepted unsafe URL schemes and arbitrary output locations | Restricted URL schemes and output to a non-symlink `_site` directory; retained HTML escaping. | Documentation security regression tests. |

## Boundaries

No OCI apply, live IAM review, state move, or resource migration was performed. Mock plans do not establish regional support, image/shape compatibility, client connectivity, or service acceptance. Customer-managed encryption keys, key rotation, workload authentication, backend TLS, NFS authentication/encryption, restricted egress, retention, backups, and disaster recovery remain workload design choices where not enforced by a specific module contract.

See [migration notes](MIGRATION.md) for behavior changes, [validation results](VALIDATION_SUMMARY.md) for actual checks, and [CHANGELOG.md](../CHANGELOG.md) for the work record.
