# OCI Naming Convention

Use lowercase, deterministic names. Prefer hyphens for display names and avoid whitespace, underscores, trailing hyphens, and repeated hyphens.

## Default Pattern

```text
<resource-type>-<workload>-<environment>
```

Examples:

```text
cmp-app-dev
vcn-app-dev
rt-app-dev
sgw-app-dev
drg-app-dev
nsg-app-dev
sl-app-dev
lb-app-dev
vm-app-dev-001
vol-app-dev-001
fss-app-dev
bucket-app-dev
vault-app-dev
key-app-dev
policy-app-dev
dg-app-dev
dns-app-dev
```

The current root composition builds `local.name_suffix` as:

```text
<workload>-<environment>
```

## Resource Prefixes

| Resource | Prefix | Example |
| --- | --- | --- |
| Compartment | `cmp` | `cmp-app-dev` |
| VCN | `vcn` | `vcn-app-dev` |
| Route table | `rt` | `rt-app-dev` |
| Service gateway | `sgw` | `sgw-app-dev` |
| Dynamic Routing Gateway | `drg` | `drg-app-dev` |
| Internet gateway | `igw` suffix | `rt-app-dev-igw` |
| NAT gateway | `nat` suffix | `rt-app-dev-nat` |
| Network security group | `nsg` | `nsg-app-dev` |
| Security list | `sl` | `sl-app-dev` |
| Load balancer | `lb` | `lb-app-dev` |
| Compute instance | `vm` | `vm-app-dev-001` |
| Block volume | `vol` | `vol-app-dev-001` |
| File Storage file system | `fss` | `fss-app-dev` |
| Object Storage bucket | `bucket` | `bucket-app-dev` |
| Vault | `vault` | `vault-app-dev` |
| KMS key | `key` | `key-app-dev` |
| IAM policy | `policy` | `policy-app-dev` |
| Dynamic group | `dg` | `dg-app-dev` |
| DNS zone | `dns` | `dns-app-dev` |

## OCI Constraints

- VCN DNS labels must be unique within the VCN's compartment and are limited to DNS-compatible characters.
- Subnet DNS labels must be unique within the VCN.
- Object Storage bucket names must be unique within the namespace and should be stable because renaming requires replacement.
- Display names are not always unique in OCI. Treat Terraform state and OCIDs as the source of truth.

## Guidance

1. Keep `workload` short and stable.
2. Use environment values such as `dev`, `test`, `prod`, or `shared`.
3. Add numeric suffixes for repeated resources, such as `vm-app-dev-001`.
4. Do not encode secrets, ticket numbers, or personal names in resource names.
5. Keep module map keys stable because they become Terraform resource addresses.
