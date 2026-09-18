# Root-Level OCI Module Guide

The root Terraform configuration composes the essential OCI modules into a small landing-zone-style baseline.

## Root Files

| File | Purpose |
| --- | --- |
| `versions.tf` | Terraform and OCI provider requirements |
| `providers.tf` | OCI provider authentication and region configuration |
| `backend.tf` | Optional OCI Object Storage remote-state backend through Terraform's S3-compatible backend |
| `data.tf` | Availability domain and Object Storage namespace lookups |
| `locals.tf` | Shared naming and tag normalization |
| `variables.tf` | Root input model |
| `main.tf` | Module wiring |
| `outputs.tf` | Useful OCIDs and names |
| `terraform.tfvars` | Example environment values |
| `.github/workflows/terraform.yml` | OCI-only CI workflow for validation, optional plan/apply, and optional GitHub demo publishing |
| `test.ps1` | Per-module validation helper used by CI |

## Root Module Order

1. `compartment`
2. `vcn`
3. `route_table`
4. `network_security_group`
5. `subnet`
6. `compute_instance`
7. `object_storage`
8. `vault`

## Authentication Inputs

The provider supports local API key authentication:

```hcl
auth                = "APIKey"
config_file_profile = "DEFAULT"
tenancy_ocid        = "ocid1.tenancy.oc1..replace-me"
user_ocid           = "ocid1.user.oc1..replace-me"
fingerprint         = "replace-me"
private_key_path    = "C:/Users/administrator/.oci/oci_api_key.pem"
region              = "us-ashburn-1"
```

It also supports security-token auth after running:

```powershell
oci session authenticate --profile tf --region us-ashburn-1
```

Then set:

```hcl
auth                = "SecurityToken"
config_file_profile = "tf"
```

## Remote State

For local validation:

```powershell
terraform init -backend=false
terraform validate
```

For OCI Object Storage remote state, export customer secret keys first:

```powershell
$env:AWS_ACCESS_KEY_ID = "<oci-customer-secret-key-access-key>"
$env:AWS_SECRET_ACCESS_KEY = "<oci-customer-secret-key-secret>"
```

Then initialize the S3-compatible backend:

```powershell
terraform init `
  -backend-config="bucket=<bucket-name>" `
  -backend-config="namespace=<object-storage-namespace>" `
  -backend-config="region=<oci-region>" `
  -backend-config="key=oci-template/terraform.tfstate" `
  -backend-config="endpoints={s3=\"https://<namespace>.compat.objectstorage.<oci-region>.oraclecloud.com\"}"
```

## Recommended First Plan

Start with compute and vault disabled:

```hcl
create_compute_instance = false
create_vault            = false
```

Then run:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
terraform plan
```

After the compartment, network, route, NSG, subnet, and bucket design is correct, enable compute or vault intentionally.

## GitHub Actions Inputs

The repository workflow does not require OCI credentials to run formatting and validation. Plan and apply jobs require OCI API key inputs.

Plan/apply inputs:

| Type | Name |
| --- | --- |
| variable | `OCI_REGION` |
| secret | `OCI_TENANCY_OCID` |
| secret | `OCI_USER_OCID` |
| secret | `OCI_FINGERPRINT` |
| secret | `OCI_PRIVATE_KEY` |

Optional remote-state inputs:

| Type | Name |
| --- | --- |
| variable | `TF_BACKEND_READY` |
| variable | `TF_BACKEND_BUCKET` |
| variable | `TF_BACKEND_NAMESPACE` |
| variable | `TF_BACKEND_REGION` |
| variable | `TF_BACKEND_KEY` |
| secret | `OCI_STATE_ACCESS_KEY_ID` |
| secret | `OCI_STATE_SECRET_ACCESS_KEY` |

Optional demo publishing inputs:

| Type | Name |
| --- | --- |
| variable | `STAGE_REPOSITORY` |
| secret | `STAGE_REPO_TOKEN` |

Apply is gated by either `workflow_dispatch` with `apply=true` or repository variable `ENABLE_GITHUB_APPLY=true`.
