# CCOE OCI Terraform Template

A library of **36 reusable Oracle Cloud Infrastructure modules** and a small private-network baseline, aligned with the sibling Azure and AWS template conventions.

Start with the [module index](docs/MODULES_INDEX.md), [cross-cloud coverage comparison](docs/PLATFORM_MODULE_COVERAGE.md), and [usage/dependencies](docs/MODULE_USAGE_AND_DEPENDENCIES.md). The [change record](CHANGELOG.md) records the ten-module expansion and subsequent hardening work.

## Baseline

The root composes nine modules: `compartment`, `vcn`, `route_table`, `network_security_group`, `security_list`, `subnet`, `compute_instance`, `object_storage`, and `vault`. Compute and Vault remain disabled by default. The root subnet uses a managed empty security list; workload access comes from explicit NSG rules. NAT egress and a private versioned bucket are enabled by default and can incur charges.

The remaining modules are opt-in building blocks. See [root behavior](docs/ROOT_LEVEL_MODULES_GUIDE.md) for inputs, outputs, and composition boundaries.

## Requirements

- Root: Terraform >= 1.12.0 for the native OCI backend; CI uses 1.15.8.
- Reusable modules and mock tests: Terraform >= 1.7.0.
- OCI provider: >= 8.23.0, < 9.0.0 throughout the repository.
- PowerShell 7 for repository helpers; terraform-docs 0.16.0 to regenerate module reference tables.

Configure OCI API-key, SecurityToken, InstancePrincipal, ResourcePrincipal, or OKEWorkloadIdentity authentication in the caller. `config_file_profile` is honored; PEM content takes precedence over a local key path. Keep credentials in protected environment variables, local OCI profiles, or CI secrets.

## Local Validation

```powershell
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
terraform test
.\test.ps1
.\scripts\Test-TerraformModules.ps1 -SkipInit -NoColor
.\scripts\Update-ModuleDocs.ps1 -Check
.\scripts\Test-DocsSecurity.ps1
```

Validation uses mock plans and does not deploy resources. See [validation results](docs/VALIDATION_SUMMARY.md).

## Configure an Environment

Copy `terraform.tfvars.example` to a local, ignored `terraform.tfvars` and replace the illustrative tenancy and workload values. Keep compute disabled until its region-valid image and OpenSSH public key are supplied.

The committed backend block is a partial native OCI configuration. Bootstrap a **private, versioned state bucket outside this state** and pass its existing location explicitly:

```powershell
terraform init `
  -backend-config="bucket=<state-bucket>" `
  -backend-config="namespace=<namespace>" `
  -backend-config="region=<state-region>" `
  -backend-config="key=<environment>/terraform.tfstate"
terraform plan
```

Supply backend credentials through the native backend's case-sensitive `OCI_tenancy_ocid`, `OCI_user_ocid`, `OCI_fingerprint`, `OCI_private_key_path`, and `OCI_region` environment variables or an appropriate local OCI profile. Provider inputs are separate. Never pass PEM content as a backend argument.

For an existing deployment, preserve the original bucket, namespace, region, key, and workspace. Read [migration notes](docs/MIGRATION.md) before reinitializing; do not apply against an accidentally empty state location.

## GitHub Actions

Validation runs formatting, root/module validation and mock tests, generated-document checks, and documentation security checks. Actions are pinned to commit SHAs. Plan/apply uses explicit OCI credentials and remote-state variables; saved plan artifacts expire after one day and temporary credentials are removed after the job. Existing origin/mirror and apply gates remain in place.

See [pipeline configuration](docs/PIPELINE.md) for the complete variable/secret list and apply behavior. Review [security controls](SECURITY.md), [hardening findings](docs/HARDENING.md), and [migration notes](docs/MIGRATION.md) before upgrading an existing deployment.
