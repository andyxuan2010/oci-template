# OCI Operations Guide

## State and Changes

Keep the state bucket private, versioned, encrypted, and outside the state that depends on it. Restrict bucket/lock-object IAM and artifact access. Preserve the backend bucket/namespace/region/key/workspace during upgrades and verify the plan reads existing state before applying. Review concurrent changes and stale plans; retain native state locking.

Use protected local tfvars or CI inputs, never committed credentials. A sensitive Terraform variable still appears in state and saved plans. Rotate compromised credentials through the owning OCI service and update consumers; deleting a local value or marking it sensitive does not revoke credentials or remove old state versions.

## Workload Controls

Validate compute image/shape support for IMDSv2 and transport encryption, NFS client UID/GID and mount behavior after root squashing, and DNS scope/view/resolver placement. Review any management-ingress exceptions. The root egress rule is intentionally broad; production consumers should apply destination-specific egress.

Create monitoring, service logs, notifications, and budgets with the existing modules. Confirm subscription recipients, metric queries, log categories, and retention. Budgets alert on spend and do not stop services; quotas limit capacity rather than enforce a monetary cap.

Test restore procedures for block volumes and databases. Avoid duplicate ownership of backup assignments. Coordinate Vault/key rotation and deletion with all consumers, and grant service principals only the key usage permissions required by the workload. Fetch application secrets at runtime where practical instead of copying them into environment maps.

## Release and Recovery

Run the [contribution checks](../CONTRIBUTING.md), review [migration notes](MIGRATION.md), and inspect the concrete live plan before applying. If a change fails, keep state intact, fix the configuration or explicitly restore the reviewed version, and reconcile actual resources before retrying. Do not use an empty state destination as a recovery shortcut.

CI plan/apply requires complete credential/state inputs and the documented deployment gate. Temporary CI key/plan files are removed and saved plan artifacts expire after one day. Re-plan if an artifact expires or state changes. Review [pipeline configuration](PIPELINE.md) when changing deployment or publishing destinations.
