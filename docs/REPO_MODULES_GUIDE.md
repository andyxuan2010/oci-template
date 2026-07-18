# OCI Repository Module Guide

This guide defines expectations for adding or changing Terraform modules in this OCI template repository.

## Module Structure

Each module should include:

```text
modules/<name>/
  versions.tf
  variables.tf
  main.tf
  outputs.tf
  README.md
  EXAMPLES.md
  tests/basic.tftest.hcl
```

Use `locals.tf` only when it makes the module clearer.

## Documentation Standard

Each module README should include:

- purpose and usage
- a working module-call example
- inputs table generated from `variables.tf`
- outputs table generated from `outputs.tf`
- Terraform test instructions

Each module `EXAMPLES.md` should include a basic copyable example and any module-specific notes.

Each module should include a mock-provider plan test at `tests/basic.tftest.hcl`. The test must use `mock_provider "oci"` and `command = plan` so it validates module wiring without calling OCI or creating resources.

## Provider Requirements

Each module should declare the OCI provider:

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 7.0.0"
    }
  }
}
```

Do not add non-OCI cloud providers to this repo.

## Input Style

Prefer:

- OCIDs for externally owned resources.
- Maps for repeated child resources.
- `freeform_tags` and `defined_tags` on taggable modules.
- Explicit booleans for optional resources that create cost or public ingress.

Avoid:

- Implicit public access.
- Hard-coded tenancy, compartment, region, user, or image OCIDs.
- Provider aliases unless the module genuinely needs multiple regions.
- Embedding secrets in tfvars, outputs, or README examples.

## Output Style

Expose OCIDs and operationally useful names:

```hcl
output "id" {
  description = "Resource OCID."
  value       = oci_example_resource.this.id
}
```

Avoid outputting secrets or private keys.

## Validation

From the repo root:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
```

For modules:

```powershell
.\test.ps1
```

To run native Terraform tests for one module:

```powershell
cd modules\<name>
terraform init -backend=false
terraform test
```

## OCI Design Defaults

- Private subnets by default.
- No public IP assignment unless explicitly requested.
- NAT gateway for private egress when needed.
- NSGs for workload-specific VNIC rules.
- Security lists only for subnet-level defaults or compatibility patterns.
- Service gateways for private OCI service access from private subnets.
- DRGs for hybrid, hub, and cross-network routing patterns.
- Private load balancers by default.
- Private Object Storage buckets by default.
- Private File Storage mount targets by default.
- Block volume backup and encryption choices should be explicit for production workloads.
- Customer-managed keys should be created through Vault and wired by OCID.
- Dynamic group matching rules and IAM policies should be narrow and reviewed before production apply.
- Compute disabled in the root sample until image and SSH key inputs are explicitly supplied.
