# Security Standard

This repository supplies infrastructure building blocks with conservative defaults and configuration checks. A passing mock plan is not a security certification or a substitute for a reviewed tenancy/network/IAM design.

## Credentials and State

Keep API signing keys, passwords, secret values, bootstrap credentials, local tfvars, and saved plans out of Git. Use OCI profiles or protected runtime/CI inputs. Never publish secret values in outputs or tags. `sensitive = true` redacts normal Terraform output but does not remove values from state or plan artifacts.

Bootstrap state in a private, versioned OCI Object Storage bucket outside the state it stores. Restrict state and lock-object permissions, enable appropriate encryption, retain recoverable versions, and preserve the exact state location during upgrades. The generic backend requires explicit bucket/namespace/region/key configuration. Local `.terraform` and lock/provider artifacts are not published by this template; production callers should manage reviewed dependency lock files for their own root configurations.

## Network and Workloads

The root uses private subnets, an empty subnet security list, and explicit NSG rules. Leaf NSG/security-list modules reject world-accessible management traffic unless an explicit exception is selected. Public HTTP/HTTPS services remain supported through deliberate endpoint and rule inputs. Narrow egress, private subnet selection, route propagation, and workload authentication are caller responsibilities.

Compute defaults to IMDSv2 and encrypted paravirtualized volume transport. Verify image/shape and guest-agent compatibility before changing existing instances. NFS exports require explicit restricted client CIDRs and default to root squash, privileged ports, and no anonymous access. Select authentication/encryption appropriate to NFS clients.

TLS listener configurations allow only TLSv1.2/TLSv1.3. Listener peer verification concerns client mTLS; it does not configure backend TLS. API Gateway HTTP backends retain certificate verification. Container repositories and API/OKE/database endpoints default to private access. Choose IAM, authentication policies, image trust, and runtime secret retrieval appropriate to each workload.

## Encryption, Retention, and Access

OCI service-managed encryption is retained where a customer-managed key is not supplied. Optional customer-managed keys require separate service permissions and lifecycle planning. Configure key rotation, backup/restore verification, database disaster recovery, object retention, log retention, and deletion policy explicitly for production.

IAM statements and dynamic group rules are explicit inputs. Nonempty checks do not prove least privilege; review tenancy/compartment scope, subject matching, resource families, verbs, and conditions. Resource creation does not grant consumers permission to use the resource.

## CI and Documentation

Actions are pinned to commits. Terraform CLI and documentation tooling use reproducible versions; downloaded documentation tooling is checksum-verified. CI reads credentials only in deployment/preflight contexts, removes temporary key/plan files, and retains saved plan artifacts for one day. Existing apply and snapshot-publishing gates are documented in the [pipeline guide](docs/PIPELINE.md).

The docs renderer escapes raw HTML, rejects executable URL schemes, and limits generated output replacement to a non-symlink `_site` directory. Security regression tests cover these boundaries.

Report findings through an organization-approved private channel; do not include credentials or sensitive state in public issues. Record material fixes and migration impact in [CHANGELOG.md](CHANGELOG.md), [hardening findings](docs/HARDENING.md), and [migration notes](docs/MIGRATION.md).
