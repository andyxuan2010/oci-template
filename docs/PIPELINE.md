# Terraform Pipeline

The GitHub Actions workflow in `.github/workflows/terraform.yml` validates this
module repository and optionally publishes, plans, and applies the root OCI
composition.

## Triggers

- Pushes to `main`, `dev`, and `sbx`
- Pull requests targeting `main`, `dev`, and `sbx`
- Manual `workflow_dispatch`, with an optional apply input

Pull requests run validation only. Plan and apply run only for non-PR events
when all required OCI credentials are configured. Publishing also excludes
pull-request events.

## OCI Authentication

Plan and apply require repository variable `OCI_REGION` and repository secrets
`OCI_TENANCY_OCID`, `OCI_USER_OCID`, `OCI_FINGERPRINT`, and `OCI_PRIVATE_KEY`.
`OCI_PRIVATE_KEY` must contain an unencrypted PEM private key, including its
BEGIN and END lines.

The workflow normalizes line endings and escaped newlines, validates the key
with OpenSSL, and then exposes it in two forms:

- A temporary `oci_api_key.pem` file for Terraform's native OCI backend
- Sensitive Terraform variable `TF_VAR_private_key` for the OCI provider

The provider configuration mirrors the working sibling `oci-landingzone`
repository: `private_key` takes precedence, while `private_key_path` remains a
fallback for local development. The CI provider does not depend on an OCI CLI
profile.

## Jobs

1. `check-required-secrets-variables` reports whether OCI, apply, and stage
   publishing inputs are available without printing secret values.
2. `validate` runs backend-disabled initialization, formatting, root
   validation, and module tests without requiring OCI credentials.
3. `publish-stage-repo` publishes a clean snapshot when its optional target
   repository and token are configured.
4. `plan` initializes the native OCI backend and uploads a saved plan artifact.
5. `apply` downloads and applies that artifact only when apply is explicitly
   enabled.

## Local Validation

```powershell
terraform fmt -check -recursive
terraform init -backend=false -input=false
terraform validate
./test.ps1
./scripts/Test-TerraformModules.ps1 -NoColor
```

For local API-key authentication, provide `private_key_path` or set the
sensitive `private_key` variable. Never commit private keys, credentials, state
files, or populated secret values.
