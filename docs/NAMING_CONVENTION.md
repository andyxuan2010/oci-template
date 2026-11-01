# OCI Naming Convention

Use deterministic, lowercase display names such as `<prefix>-<workload>-<environment>`. Root workload/environment inputs accept lowercase alphanumeric segments separated by single hyphens. Leaf module names are caller-owned; existing names and stable map keys should be preserved to avoid replacements.

| Resource | Example |
| --- | --- |
| Compartment / VCN / subnet | `cmp-app-dev`, `vcn-app-dev`, `app` |
| Route table / NSG / security list | `rt-app-dev`, `nsg-app-dev`, `sl-app-dev` |
| Compute / block / file storage | `vm-app-dev-001`, `vol-app-dev-001`, `fss-app-dev` |
| Bucket / Vault / key | `bucket-app-dev`, `vault-app-dev`, `key-app-dev` |
| IAM policy / dynamic group | `policy-app-dev`, `dg-app-dev` |
| DNS zone / record | `internal.example.com`, `app.internal.example.com` |
| OKE / registry | `oke-app-dev`, `platform/app` |
| Autonomous Database | display `adb-app-dev`, database identifier `APPDEV` |
| API Gateway / Functions | `apigw-app-dev`, `fnapp-app-dev` |
| Queue / event / backup policy | `queue-app-dev`, `events-storage-dev`, `backup-app-dev` |
| Budget / log group / alarm / topic | `budget-app-dev`, `logs-app-dev`, `alarm-app-dev`, `topic-app-dev` |

Service-specific identifiers have separate constraints. Database names use 1-14 alphanumeric characters starting with a letter. DNS labels and records follow OCI/DNS constraints; bucket names are namespace-scoped; registry paths can contain slashes. Display names are not always unique, so OCIDs and Terraform state remain the identity boundary.

Never encode secrets or personal data in names. Pin production module source refs and keep resource-map keys stable across refactors. See [migration notes](MIGRATION.md) before renaming deployed resources.
