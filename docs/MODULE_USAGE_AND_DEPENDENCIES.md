# OCI Module Usage and Dependencies

This document explains how the current OCI modules fit together and what must exist before each module can be planned or applied.

## Recommended Deployment Order

1. Configure OCI authentication and provider inputs.
2. Create or select the workload compartment.
3. Create the VCN.
4. Create route tables and any required gateways.
5. Create NSGs and security rules.
6. Create subnets.
7. Add subnet-level security lists if required by the network design.
8. Add workload resources such as compute, load balancers, block volumes, file storage, object storage, DNS, IAM policies, dynamic groups, keys, and vaults.

Prefer wiring modules together through outputs instead of copying OCIDs into tfvars files. Use explicit OCIDs only for resources intentionally owned outside this repo.

Every module includes:

- `README.md` for usage, inputs, outputs, and test instructions
- `EXAMPLES.md` for a basic module call
- `tests/basic.tftest.hcl` for a mock-provider plan test

## Dependency Matrix

| Module | Primary use case | Required dependencies | Optional dependencies |
| --- | --- | --- | --- |
| `compartment` | Workload isolation boundary | Tenancy OCID or parent compartment OCID | Defined tags |
| `vcn` | Network foundation | Compartment OCID | DNS label, defined tags |
| `route_table` | Subnet routing and egress | Compartment OCID, VCN OCID | NAT gateway, internet gateway, custom gateway OCIDs |
| `service_gateway` | Private VCN access to supported OCI services | Compartment OCID, VCN OCID, service ID or service name | Route table association |
| `drg` | Hub, hybrid, and cross-network routing | Compartment OCID | VCN attachments, DRG route table IDs |
| `network_security_group` | VNIC-level network controls | Compartment OCID, VCN OCID | TCP, UDP, ICMP rule options |
| `security_list` | Subnet-level security defaults | Compartment OCID, VCN OCID | TCP, UDP, ICMP rule options |
| `subnet` | Workload network segmentation | Compartment OCID, VCN OCID | Route table ID, security list IDs, NSGs consumed by downstream VNICs |
| `compute_instance` | Linux VM workload | Compartment OCID, availability domain, subnet OCID, image OCID, SSH public key | NSG IDs, flexible shape config, cloud-init |
| `block_volume` | Persistent compute data disk | Compartment OCID, availability domain | Backup policy, Vault key, compute instance attachment |
| `file_storage` | Shared NFS storage | Compartment OCID, availability domain, subnet OCID | NSGs, Vault key, export options |
| `load_balancer` | Private or public service frontend | Compartment OCID, subnet OCIDs | NSGs, backend sets, backends, listeners, TLS certificate references |
| `object_storage` | Private bucket for artifacts, state support, or workload storage | Compartment OCID, Object Storage namespace | Versioning, storage tier, defined tags |
| `vault` | Key-management foundation | Compartment OCID | Vault type, defined tags |
| `kms_key` | Customer-managed encryption key | Compartment OCID, Vault management endpoint | Auto-rotation, defined tags |
| `iam_policy` | Workload-specific IAM authorization | Compartment OCID, policy statements | Defined tags |
| `dynamic_group` | Resource-principal identity grouping | Tenancy OCID, matching rule | IAM policy statements |
| `dns_zone` | Public or private DNS zone | Compartment OCID | Private DNS view ID |

## Common Dependency Chains

- `compartment` -> `vcn` -> `route_table` -> `subnet`
- `compartment` -> `vcn` -> `service_gateway` -> `route_table`
- `compartment` -> `drg` -> VCN attachments
- `compartment` -> `vcn` -> `network_security_group` -> `compute_instance`
- `compartment` -> `vcn` -> `security_list` -> `subnet`
- `compartment` -> `vcn` -> `subnet` -> `load_balancer`
- `compartment` -> `compute_instance` -> `block_volume`
- `compartment` -> `vcn` -> `subnet` -> `file_storage`
- `compartment` -> `object_storage`
- `compartment` -> `vault`
- `compartment` -> `vault` -> `kms_key`
- `tenancy` -> `dynamic_group` -> `iam_policy`
- `compartment` -> `iam_policy`
- `compartment` -> `dns_zone`

## Root Composition Behavior

The root composition can either create a child compartment or use an existing compartment:

```hcl
create_compartment = true
```

or:

```hcl
create_compartment = false
compartment_ocid   = "ocid1.compartment.oc1..replace-me"
```

By default, the root creates:

- one compartment
- one VCN
- one route table with NAT gateway egress
- one NSG
- one private subnet
- one Object Storage bucket

The root does not create compute or vault resources unless explicitly enabled:

```hcl
create_compute_instance = true
compute_image_ocid      = "ocid1.image.oc1..replace-me"
ssh_public_key          = "ssh-rsa replace-me"

create_vault = true
```

## Module Notes

### `compartment`

Use this as the default workload boundary. If your organization already provisions compartments through a separate landing-zone process, disable `create_compartment` and pass `compartment_ocid`.

### `vcn`

Use this for the network address boundary. Keep CIDR blocks non-overlapping with connected VCNs, on-premises networks, and DR environments.

### `route_table`

Use NAT gateway routes for private subnet egress. Use internet gateway routes only for public subnet patterns where public IP assignment is intentional.

### `service_gateway`

Use service gateways when private subnets need access to supported OCI services without traversing the public internet. Pair them with explicit route table rules.

### `drg`

Use DRGs for hybrid connectivity, hub-and-spoke, FastConnect, VPN, and cross-network routing. Keep routing tables and route distribution behavior explicit in production designs.

### `network_security_group`

Use NSGs for workload-specific VNIC controls. OCI NSGs attach to VNICs and load balancers, not directly to subnets.

### `security_list`

Use security lists for subnet-level defaults or legacy designs. Prefer NSGs for application-specific controls because they attach closer to the workload.

### `subnet`

Use private subnets by default with `prohibit_public_ip_on_vnic = true`. Create separate public subnets only when a workload explicitly needs public ingress.

### `compute_instance`

Keep compute disabled until image OCID, SSH key handling, patching, bootstrap, and network access are agreed for the target environment.

### `block_volume`

Use block volumes for persistent data disks. Keep backup policy and encryption key choices explicit so production workloads have predictable recovery and security behavior.

### `file_storage`

Use file storage for shared NFS access. Keep mount targets private and restrict exports with network controls and explicit export options.

### `load_balancer`

Use private load balancers by default for internal application tiers. Public load balancers should be paired with intentional listener, NSG, and certificate choices.

### `object_storage`

Use private buckets by default. If the bucket is used for Terraform state, create it before enabling the remote backend.

### `vault`

Enable this when the workload needs managed keys or secrets. Plan IAM policies for key administrators and key users before production use.

### `kms_key`

Use this module to create customer-managed keys inside an OCI Vault. Pass key OCIDs to storage modules that support customer-managed encryption.

### `iam_policy`

Use this module to make workload authorization explicit. Keep statements narrow, compartment-scoped when possible, and reviewed before production apply.

### `dynamic_group`

Use dynamic groups to grant permissions to resources such as compute instances using instance principals or resource principals. Pair dynamic groups with narrowly scoped IAM policies.

### `dns_zone`

Use global zones for public DNS and private zones with a private view for internal name resolution.
