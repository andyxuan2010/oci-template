# OCI Module Usage and Dependencies

Compose modules through outputs rather than copying internally owned OCIDs. Externally owned resources remain explicit OCID inputs. IAM, network reachability, regional availability, and service limits must be reviewed separately from Terraform syntax.

## Dependency Matrix

| Module | Prerequisites |
| --- | --- |
| [`api_gateway`](../modules/api_gateway/README.md) | Compartment and subnet; optional HTTPS backends with DNS/routing |
| [`autonomous_database`](../modules/autonomous_database/README.md) | Compartment, private subnet and sensitive ADMIN password |
| [`bastion`](../modules/bastion/README.md) | Compartment, target subnet and restricted standard-client CIDRs |
| [`block_volume`](../modules/block_volume/README.md) | Compartment and AD; optional instance, KMS key and backup policy |
| [`budget`](../modules/budget/README.md) | Compartment/tenancy, positive amount and spend targets |
| [`compartment`](../modules/compartment/README.md) | Parent tenancy/compartment and deployment IAM |
| [`compartment_quota`](../modules/compartment_quota/README.md) | Compartment and reviewed OCI quota statements |
| [`compute_instance`](../modules/compute_instance/README.md) | Compartment, AD, subnet, region-valid image, shape, OpenSSH public key |
| [`container_repository`](../modules/container_repository/README.md) | Compartment; registry IAM and external image publishing |
| [`dns_record`](../modules/dns_record/README.md) | Existing zone OCID, matching scope, domain/type and nonempty records |
| [`dns_zone`](../modules/dns_zone/README.md) | Compartment; private view/resolver design or explicit public scope |
| [`drg`](../modules/drg/README.md) | Compartment; existing VCN IDs for optional attachments |
| [`dynamic_group`](../modules/dynamic_group/README.md) | Tenancy and a reviewed narrow matching rule |
| [`events_rule`](../modules/events_rule/README.md) | Compartment, JSON condition, ONS/Functions/Streaming destination and delivery IAM |
| [`file_storage`](../modules/file_storage/README.md) | Compartment, AD, subnet, explicit restricted export clients; optional KMS key |
| [`functions`](../modules/functions/README.md) | Compartment and private subnets; compatible images and registry IAM for functions |
| [`iam_policy`](../modules/iam_policy/README.md) | Compartment and reviewed explicit IAM statements |
| [`kms_key`](../modules/kms_key/README.md) | Compartment and Vault management endpoint; rotation schedule when enabled |
| [`load_balancer`](../modules/load_balancer/README.md) | Compartment, subnets; backend sets, backends, listeners and optional certificates |
| [`logging`](../modules/logging/README.md) | Compartment; service resource/category identifiers for service logs |
| [`monitoring_alarm`](../modules/monitoring_alarm/README.md) | Alarm/metric compartments, namespace, query and notification topic IDs |
| [`network_security_group`](../modules/network_security_group/README.md) | Compartment and VCN; explicit source/destination rules |
| [`notification_topic`](../modules/notification_topic/README.md) | Compartment; optional confirmed subscription endpoints |
| [`object_storage`](../modules/object_storage/README.md) | Compartment and Object Storage namespace; optional KMS key |
| [`oke`](../modules/oke/README.md) | Compartment, VCN, private endpoint subnet, Kubernetes version; worker images/placements when enabled |
| [`queue`](../modules/queue/README.md) | Compartment; producer/consumer IAM and optional KMS key |
| [`route_table`](../modules/route_table/README.md) | Compartment, VCN, enabled symbolic gateway or external gateway OCIDs |
| [`security_list`](../modules/security_list/README.md) | Compartment and VCN; empty rules are valid |
| [`service_gateway`](../modules/service_gateway/README.md) | Compartment, VCN, regional OCI service IDs |
| [`subnet`](../modules/subnet/README.md) | Compartment, VCN, CIDRs; route table and security lists |
| [`tag_default`](../modules/tag_default/README.md) | Compartment and existing defined-tag ID |
| [`tag_namespace`](../modules/tag_namespace/README.md) | Compartment and organization tag definitions |
| [`vault`](../modules/vault/README.md) | Compartment and Vault design |
| [`vault_secret`](../modules/vault_secret/README.md) | Compartment, Vault, symmetric key and sensitive value |
| [`vcn`](../modules/vcn/README.md) | Compartment and non-overlapping IPv4 CIDRs |
| [`volume_backup_policy`](../modules/volume_backup_policy/README.md) | Compartment and schedules; optional existing volume/group asset IDs |

## Common Chains

- Compartment -> VCN -> route table/gateways + NSGs/security lists -> subnets -> compute, load balancers, OKE, Functions, database or API Gateway.
- Vault -> KMS key -> Vault secret; optional key use by bucket, queue, volumes and file systems requires service IAM.
- Registry -> external image build/push -> Functions or Kubernetes workloads.
- Notifications topic or Functions -> Events rule. Streaming destinations can be supplied externally; Events rules do not target Queue directly.
- Backup policy -> block-volume `backup_policy_id`, or explicit backup-policy asset assignments. Use one owner per assignment.
- DNS zone -> DNS record set. One call owns the complete zone/domain/type RRSet.
- Tag namespace/definition -> defined-tag consumers or tag defaults; budgets and quotas implement separate governance controls.

The root composes nine baseline modules and leaves workload services opt-in. It uses an empty security list with explicit NSG workload access. Existing-compartment mode requires an OCID; compute mode requires an image and public key. See [root composition](ROOT_LEVEL_MODULES_GUIDE.md), [cross-cloud coverage](PLATFORM_MODULE_COVERAGE.md), and [migration notes](MIGRATION.md).
