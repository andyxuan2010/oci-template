# OCI Validation Summary

## Current Status

The root OCI Terraform configuration validates successfully.

Validated commands:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
.\test.ps1
```

Result:

```text
Success! The configuration is valid.
```

Terraform/provider versions observed during validation:

```text
Terraform v1.10.5
registry.terraform.io/oracle/oci v8.23.0
```

The GitHub workflow performs validation with `terraform init -backend=false`, `terraform fmt -check -recursive`, `terraform validate -no-color`, and `./test.ps1`.

Each module also has a native Terraform mock-provider test at `modules/<name>/tests/basic.tftest.hcl`. Run one module test with:

```powershell
cd modules\<name>
terraform init -backend=false
terraform test
```

## Validated Scope

- Root provider and variable wiring.
- Compartment module.
- VCN module.
- Route table module with optional NAT and internet gateway resources.
- Service gateway module.
- DRG module with optional VCN attachments.
- Network security group module with ingress and egress rules.
- Security list module with ingress and egress rules.
- Subnet module.
- Compute instance module.
- Block volume module with optional backup policy assignment and instance attachment.
- File Storage module with file system, mount target, and export resources.
- Load balancer module with backend sets, backends, and listeners.
- Object Storage module.
- Vault module.
- KMS key module.
- IAM policy module.
- Dynamic group module.
- DNS zone module.

## Not Yet Validated by Live Plan

The following require real OCI tenancy values and IAM permissions:

- Remote state in OCI Object Storage.
- Compartment creation under the target tenancy.
- Actual VCN and subnet deployment.
- Compute launch with a region-valid image OCID.
- Vault creation and key-management IAM policies.
- GitHub Actions plan/apply using repository secrets in a live OCI tenancy.

## Recommended Next Validation

Use a real environment tfvars file and start without compute:

```powershell
terraform init -backend=false
terraform plan -var-file="terraform.tfvars"
```

Then enable compute after setting:

```hcl
create_compute_instance = true
compute_image_ocid      = "ocid1.image.oc1..replace-me"
ssh_public_key          = "ssh-rsa replace-me"
```
