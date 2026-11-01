# Migration Notes

Review a saved plan and state backup before adopting the hardening changes. No live state migration or OCI apply was performed as part of this repository update.

## Tooling and Contracts

All modules require Terraform >= 1.7.0 and OCI provider >= 8.23.0, < 9.0.0. The root requires Terraform >= 1.12.0; CI uses 1.15.8. Review existing provider selections before initialization, especially callers using an older provider or a newer major. Maintain production root lock files and validate upgrades against backed-up state.

Required inputs and non-null defaults are explicitly non-nullable. A null passed to a non-null default uses the default; required null values are rejected. Optional nullable inputs remain null by default. Existing variable names, module directories, NSG list indices, and existing resource addresses are retained. Subnet `nsg_ids` remains a documented no-op compatibility field; attach NSGs to supported resource interfaces instead.

## Remote State and Environment Inputs

`terraform.tfvars` was replaced by an illustrative `terraform.tfvars.example`; copy it locally and supply real values through ignored environment files or protected runtime inputs. The committed backend is now partial instead of containing an environment-specific location.

For an existing deployment, recover the **same** bucket, namespace, region, object key, and workspace from the previous backend configuration before reinitializing. Pass those location values to `terraform init`; do not switch to a new empty bucket/key and apply. Credentials stay in the native backend's environment/profile. No state destination is created or migrated automatically.

Configure CI variables `OCI_STATE_BUCKET`, `OCI_STATE_NAMESPACE`, and `OCI_STATE_KEY` before expecting plan/apply to run. Set `OCI_STATE_REGION` only if it differs from `OCI_REGION`. Missing state inputs skip deployment jobs. Provider region/tenancy/user/fingerprint now come from the corresponding protected CI inputs rather than the committed tfvars sample.

## Resource Behavior Changes

| Change | Required review |
| --- | --- |
| Root adds `module.security_list` and associates subnets with its empty list | Rules inherited from the VCN default list stop granting access; ensure required traffic is explicitly allowed by workload NSGs. |
| Compute defaults to disabling legacy IMDS endpoints | Upgrade guest agents and bootstrap clients to IMDSv2; use the explicit compatibility input only when justified. |
| Compute and paravirtualized block attachments default to encryption in transit | Confirm image/shape compatibility and review whether the plan replaces or reconfigures attachments/instances. Non-PV attachments are outside this flag. |
| File Storage requires nonempty restricted export CIDRs | Replace implicit or /0 export rules; validate actual client networks. |
| NFS defaults to ROOT squash and privileged source ports | Review UID/GID ownership, mount options, and client behavior before applying. |
| NSG/security-list world-accessible management rules are rejected | Narrow sources; if intentionally required, set `allow_unrestricted_management_ingress = true` and record the exception. Public HTTPS rules remain allowed. |
| DNS zones default to PRIVATE | Existing public zones must keep `scope = "GLOBAL"` explicit to avoid an unintended scope/replacement change. |
| Configured TLS listeners permit only TLSv1.2/TLSv1.3 | Update clients and select valid certificate references. Client mTLS remains explicit. |
| Validation rejects malformed CIDRs/ports, empty IAM statements, missing Bastion clients, and invalid rotation schedules | Correct inputs before planning; IAM checks do not certify authorization scope. |

The ten-module expansion remains opt-in: no OKE, database, Functions, queue, event, secret, API Gateway, custom backup, container repository, or DNS RRSet deployment is added automatically to the root.

See [validation evidence](VALIDATION_SUMMARY.md), [security controls](../SECURITY.md), and [operations](OPERATIONS.md). Apply only after reviewing the concrete plan against the target state and network design.
