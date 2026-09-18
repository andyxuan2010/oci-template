# OCI Modules Index

This index reflects the current OCI Terraform module inventory under `modules/`.

## Root Docs

- [readme.MD](../readme.MD)
- [MODULE_USAGE_AND_DEPENDENCIES.md](./MODULE_USAGE_AND_DEPENDENCIES.md)
- [NAMING_CONVENTION.md](./NAMING_CONVENTION.md)
- [REPO_MODULES_GUIDE.md](./REPO_MODULES_GUIDE.md)
- [ROOT_LEVEL_MODULES_GUIDE.md](./ROOT_LEVEL_MODULES_GUIDE.md)
- [TAGGING_STANDARD.md](./TAGGING_STANDARD.md)
- [VALIDATION_SUMMARY.md](./VALIDATION_SUMMARY.md)

Generated reports and pipeline diagrams are intentionally not kept in `docs/`; this folder should reflect the current source tree.

## Modules

| Module | Purpose | README | Examples | Test |
| --- | --- | --- | --- | --- |
| `compartment` | Creates a child OCI compartment for workload isolation. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/compartment/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/compartment/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/compartment/tests/basic.tftest.hcl) |
| `vcn` | Creates an OCI Virtual Cloud Network. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/vcn/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/vcn/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/vcn/tests/basic.tftest.hcl) |
| `route_table` | Creates a route table and optional internet or NAT gateways. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/route_table/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/route_table/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/route_table/tests/basic.tftest.hcl) |
| `service_gateway` | Creates a service gateway for private access to supported OCI services. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/service_gateway/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/service_gateway/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/service_gateway/tests/basic.tftest.hcl) |
| `drg` | Creates a Dynamic Routing Gateway and optional VCN attachments. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/drg/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/drg/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/drg/tests/basic.tftest.hcl) |
| `network_security_group` | Creates an OCI NSG and ingress or egress security rules. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/network_security_group/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/network_security_group/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/network_security_group/tests/basic.tftest.hcl) |
| `security_list` | Creates an OCI security list and optional ingress or egress rules. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/security_list/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/security_list/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/security_list/tests/basic.tftest.hcl) |
| `subnet` | Creates one or more subnets in a VCN. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/subnet/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/subnet/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/subnet/tests/basic.tftest.hcl) |
| `compute_instance` | Creates a Linux compute instance with VNIC, NSG attachment, SSH key, and optional cloud-init. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/compute_instance/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/compute_instance/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/compute_instance/tests/basic.tftest.hcl) |
| `block_volume` | Creates a block volume with optional backup policy assignment and instance attachment. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/block_volume/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/block_volume/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/block_volume/tests/basic.tftest.hcl) |
| `file_storage` | Creates File Storage file system, mount target, and NFS export resources. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/file_storage/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/file_storage/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/file_storage/tests/basic.tftest.hcl) |
| `load_balancer` | Creates an OCI load balancer with backend sets, backends, and listeners. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/load_balancer/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/load_balancer/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/load_balancer/tests/basic.tftest.hcl) |
| `object_storage` | Creates an Object Storage bucket with private access and versioning by default. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/object_storage/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/object_storage/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/object_storage/tests/basic.tftest.hcl) |
| `vault` | Creates an OCI Vault for secrets and key-management foundations. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/vault/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/vault/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/vault/tests/basic.tftest.hcl) |
| `kms_key` | Creates an OCI Vault key from a Vault management endpoint. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/kms_key/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/kms_key/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/kms_key/tests/basic.tftest.hcl) |
| `iam_policy` | Creates OCI IAM policies from explicit policy statements. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/iam_policy/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/iam_policy/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/iam_policy/tests/basic.tftest.hcl) |
| `dynamic_group` | Creates an OCI dynamic group for resource-principal authorization. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/dynamic_group/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/dynamic_group/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/dynamic_group/tests/basic.tftest.hcl) |
| `dns_zone` | Creates public or private OCI DNS zones. | [README.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/dns_zone/README.md) | [EXAMPLES.md](.git::https://github.com/andyxuan2010/oci-template.git//modules/dns_zone/EXAMPLES.md) | [basic.tftest.hcl](.git::https://github.com/andyxuan2010/oci-template.git//modules/dns_zone/tests/basic.tftest.hcl) |
## Root Composition

The root module wires the modules in this order:

1. `compartment`
2. `vcn`
3. `route_table`
4. `network_security_group`
5. `subnet`
6. `compute_instance`
7. `object_storage`
8. `vault`

Additional reusable modules are intentionally not root-wired yet:

- `block_volume`
- `dns_zone`
- `drg`
- `dynamic_group`
- `file_storage`
- `iam_policy`
- `kms_key`
- `load_balancer`
- `security_list`
- `service_gateway`

Compute and Vault are root-wired but disabled by default because they require workload-specific choices such as image OCIDs, SSH keys, and key-management design.

## Scripts

| Script | Purpose |
| --- | --- |
| `test.ps1` | Active per-module `terraform init -backend=false` and `terraform validate` helper. Used by the GitHub workflow. |
| `scripts/post_init_script.sh` | Sample Linux post-init script that can be supplied as compute cloud-init content. |
| `scripts/ubuntu.sh` | Sample Ubuntu localization/bootstrap script. |
| `scripts/terraform-change-summary.sh` | Optional helper for summarizing a saved Terraform plan JSON with `jq`. |
| `scripts/create-release-tag.sh` | Optional helper for creating semantic release tags from Git history. |
| `scripts/Test-TerraformModules.ps1` | Native `terraform test` runner for module `tests/basic.tftest.hcl` files. |

## GitHub Workflow

| Workflow | Purpose |
| --- | --- |
| `.github/workflows/terraform.yml` | OCI-only validation, optional plan/apply, and optional GitHub demo repository publishing. |

## Validation

From the repository root:

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
```

For per-module validation:

```powershell
.\test.ps1
```
