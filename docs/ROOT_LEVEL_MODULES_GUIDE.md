# OCI Root Composition

The root is a sample baseline built from nine modules, not an automatic deployment of the entire library.

| Module | Behavior |
| --- | --- |
| `compartment` | Creates a child compartment by default, or uses `compartment_ocid` when disabled. |
| `vcn` | Creates the workload address boundary. |
| `route_table` | Creates a route table and NAT gateway by default; internet gateway is opt-in. |
| `network_security_group` | Allows SSH within the first VCN CIDR and explicit outbound traffic. |
| `security_list` | Creates an empty list so subnets do not inherit OCI default-list rules. |
| `subnet` | Creates caller-defined subnets; VNIC public IPs are prohibited by default. |
| `compute_instance` | Disabled by default; requires an image and SSH public key when enabled. Uses IMDSv2 and encrypted paravirtualized transport by default. |
| `object_storage` | Creates a private versioned workload bucket by default; this is separate from the bootstrapped state bucket. |
| `vault` | Disabled by default. |

All other modules are independently composed by workload callers. Resource addresses in the original root remain intact; `module.security_list` and output `security_list_id` are additions. The subnet security-list association changes on upgrade and must be reviewed for traffic impact.

## Authentication and State

Provider authentication uses root variables or `config_file_profile`. PEM content takes precedence over `private_key_path`. The root validates authentication mode, naming inputs, existing-compartment selection, and enabled compute prerequisites.

The partial native OCI backend receives its location during initialization. Preserve bucket/namespace/region/key/workspace for existing deployments. Credentials are runtime inputs. See [migration](MIGRATION.md), [operations](OPERATIONS.md), and [pipeline configuration](PIPELINE.md).

## Inputs and Outputs

`variables.tf` is the root input contract; it includes region, tenancy, authentication, workload/environment naming, CIDRs/subnets, optional compute, bucket, and Vault choices. `outputs.tf` exposes compartment, VCN, subnet, NSG, route table, empty security-list, optional compute, workload bucket, and Vault identifiers. No private key or secret value is exported.

Root tags merge caller tags with deterministic `workload`, `environment`, and `managed_by = "terraform"` values. Standalone modules do not add those tags automatically. Broad outbound NSG traffic remains an explicit sample rule; restrict egress for each production workload.
