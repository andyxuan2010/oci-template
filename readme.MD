# CCOE OCI Terraform Template

This repo contains reusable Terraform modules for Oracle Cloud Infrastructure. The essential OCI modules are under `modules/` and the root composition wires them together into a small landing-zone-style baseline.

## Modules

- `compartment`: workload isolation container.
- `vcn`: OCI Virtual Cloud Network.
- `route_table`: route table plus optional NAT and internet gateways.
- `service_gateway`: private access from a VCN to supported OCI services.
- `drg`: Dynamic Routing Gateway with optional VCN attachments.
- `network_security_group`: OCI NSG and security rules.
- `security_list`: subnet-level security list and rules.
- `subnet`: subnet creation inside the VCN.
- `compute_instance`: Linux compute instance with VNIC, NSG attachment, SSH key, and optional cloud-init.
- `block_volume`: block volume with optional backup policy assignment and instance attachment.
- `file_storage`: File Storage file system, mount target, and NFS export.
- `load_balancer`: load balancer with backend sets, backends, and listeners.
- `object_storage`: private Object Storage bucket with versioning.
- `vault`: OCI Vault foundation.
- `kms_key`: Vault key for customer-managed encryption.
- `iam_policy`: OCI IAM policies from explicit statements.
- `dynamic_group`: dynamic group for instance/resource-principal authorization.
- `dns_zone`: public or private OCI DNS zones.

## Environment Setup

Install:

1. Terraform CLI 1.5 or newer.
2. OCI CLI.
3. An OCI tenancy, region, user, compartment strategy, and IAM policy that allows Terraform to manage the target resources.

For local API key auth:

1. Generate an OCI API signing key.
2. Upload the public key to your OCI user.
3. Configure `~/.oci/config` or set the values in your tfvars file:
   - `tenancy_ocid`
   - `user_ocid`
   - `fingerprint`
   - `private_key_path`
   - `region`

For short-lived local auth:

```powershell
oci session authenticate --profile tf --region us-ashburn-1
```

Then set:

```hcl
auth                = "SecurityToken"
config_file_profile = "tf"
```

## State Backend

The root `backend.tf` uses Terraform's native OCI backend and stores state in
the private, versioned `tfstate-oci-template-dev` Object Storage bucket. The
native backend requires Terraform 1.12 or newer and uses the same OCI API-key
credentials as the provider.

```powershell
terraform init
```

If you are just validating the module code locally, use:

```powershell
terraform init -backend=false
terraform validate
```

## First Run

1. Update `terraform.tfvars` or create an environment-specific tfvars file.
2. Start with `create_compute_instance = false` until the network and compartment baseline is planned successfully.
3. Run:

```powershell
terraform init
terraform plan
```

4. Confirm that the plan is reading the existing remote state before applying.

## GitHub Actions

The workflow in `.github/workflows/terraform.yml` is OCI-only. It validates Terraform on pushes and pull requests, can publish a clean snapshot to another GitHub repository, and can run plan/apply when OCI credentials are configured.

Required for plan/apply:

- Repository variable `OCI_REGION`
- Repository secrets `OCI_TENANCY_OCID`, `OCI_USER_OCID`, `OCI_FINGERPRINT`, `OCI_PRIVATE_KEY`

The native OCI backend in `backend.tf` stores state in OCI Object Storage and
uses the same OCI API-key credentials. No S3-compatible customer secret keys or
additional backend variables are required.

Optional for GitHub demo publishing:

- Repository variable `STAGE_REPOSITORY`
- Repository secret `STAGE_REPO_TOKEN`

## OCI Notes

- Compartments are the primary workload isolation boundary.
- VCNs provide the network address boundary.
- NSGs attach to VNICs and load balancers, not directly to subnets.
- Object Storage buckets are private by default in this template.
- Compute is disabled by default until image, SSH key, and bootstrap choices are explicit.
