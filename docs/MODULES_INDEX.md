# OCI Modules Index

The library contains **36 modules**. Ten were added in the platform expansion; all 36 now share provider/version declarations, explicit input nullability, generated references, canonical source URLs, and formatting conventions.

| Module | Purpose | Usage | Tests |
| --- | --- | --- | --- |
| [`api_gateway`](../modules/api_gateway/README.md) | Creates a private API Gateway with optional HTTP backend deployments. | [Examples](../modules/api_gateway/EXAMPLES.md) | [Plan tests](../modules/api_gateway/tests/basic.tftest.hcl) |
| [`autonomous_database`](../modules/autonomous_database/README.md) | Creates an Autonomous Transaction Processing database with a private endpoint and mutual TLS enabled. | [Examples](../modules/autonomous_database/EXAMPLES.md) | [Plan tests](../modules/autonomous_database/tests/basic.tftest.hcl) |
| [`bastion`](../modules/bastion/README.md) | Creates an OCI Bastion endpoint for controlled access to private targets. | [Examples](../modules/bastion/EXAMPLES.md) | [Plan tests](../modules/bastion/tests/basic.tftest.hcl) |
| [`block_volume`](../modules/block_volume/README.md) | Creates an OCI block volume, optionally assigns a backup policy, and optionally attaches it to a compute instance. | [Examples](../modules/block_volume/EXAMPLES.md) | [Plan tests](../modules/block_volume/tests/basic.tftest.hcl) |
| [`budget`](../modules/budget/README.md) | Creates an OCI budget and optional alert rules for a compartment or tag target. | [Examples](../modules/budget/EXAMPLES.md) | [Plan tests](../modules/budget/tests/basic.tftest.hcl) |
| [`compartment`](../modules/compartment/README.md) | Creates a child OCI compartment for workload isolation. | [Examples](../modules/compartment/EXAMPLES.md) | [Plan tests](../modules/compartment/tests/basic.tftest.hcl) |
| [`compartment_quota`](../modules/compartment_quota/README.md) | Creates an OCI quota policy from explicit quota statements. | [Examples](../modules/compartment_quota/EXAMPLES.md) | [Plan tests](../modules/compartment_quota/tests/basic.tftest.hcl) |
| [`compute_instance`](../modules/compute_instance/README.md) | Creates an OCI compute instance with primary VNIC, optional flexible shape settings, SSH key, and optional cloud-init. | [Examples](../modules/compute_instance/EXAMPLES.md) | [Plan tests](../modules/compute_instance/tests/basic.tftest.hcl) |
| [`container_repository`](../modules/container_repository/README.md) | Creates an OCI Container Registry repository with private access and immutable image tags by default. | [Examples](../modules/container_repository/EXAMPLES.md) | [Plan tests](../modules/container_repository/tests/basic.tftest.hcl) |
| [`dns_record`](../modules/dns_record/README.md) | Manages an entire DNS record set in an existing public or private OCI DNS zone. | [Examples](../modules/dns_record/EXAMPLES.md) | [Plan tests](../modules/dns_record/tests/basic.tftest.hcl) |
| [`dns_zone`](../modules/dns_zone/README.md) | Creates a public or private OCI DNS zone. | [Examples](../modules/dns_zone/EXAMPLES.md) | [Plan tests](../modules/dns_zone/tests/basic.tftest.hcl) |
| [`drg`](../modules/drg/README.md) | Creates an OCI Dynamic Routing Gateway and optional VCN attachments. | [Examples](../modules/drg/EXAMPLES.md) | [Plan tests](../modules/drg/tests/basic.tftest.hcl) |
| [`dynamic_group`](../modules/dynamic_group/README.md) | Creates an OCI dynamic group from an explicit matching rule. | [Examples](../modules/dynamic_group/EXAMPLES.md) | [Plan tests](../modules/dynamic_group/tests/basic.tftest.hcl) |
| [`events_rule`](../modules/events_rule/README.md) | Routes matching OCI service events to Notifications, Functions, or Streaming destinations. | [Examples](../modules/events_rule/EXAMPLES.md) | [Plan tests](../modules/events_rule/tests/basic.tftest.hcl) |
| [`file_storage`](../modules/file_storage/README.md) | Creates an OCI File Storage file system, mount target, and NFS export. | [Examples](../modules/file_storage/EXAMPLES.md) | [Plan tests](../modules/file_storage/tests/basic.tftest.hcl) |
| [`functions`](../modules/functions/README.md) | Creates an OCI Functions application and optional container-image functions in caller-selected subnets. | [Examples](../modules/functions/EXAMPLES.md) | [Plan tests](../modules/functions/tests/basic.tftest.hcl) |
| [`iam_policy`](../modules/iam_policy/README.md) | Creates an OCI IAM policy from explicit policy statements. | [Examples](../modules/iam_policy/EXAMPLES.md) | [Plan tests](../modules/iam_policy/tests/basic.tftest.hcl) |
| [`kms_key`](../modules/kms_key/README.md) | Creates an OCI Vault key from a Vault management endpoint. | [Examples](../modules/kms_key/EXAMPLES.md) | [Plan tests](../modules/kms_key/tests/basic.tftest.hcl) |
| [`load_balancer`](../modules/load_balancer/README.md) | Creates an OCI load balancer with optional backend sets, backends, and listeners. | [Examples](../modules/load_balancer/EXAMPLES.md) | [Plan tests](../modules/load_balancer/tests/basic.tftest.hcl) |
| [`logging`](../modules/logging/README.md) | Creates an OCI log group and zero or more service/custom logs. | [Examples](../modules/logging/EXAMPLES.md) | [Plan tests](../modules/logging/tests/basic.tftest.hcl) |
| [`monitoring_alarm`](../modules/monitoring_alarm/README.md) | Creates one OCI Monitoring alarm with notification destinations and an optional suppression window. | [Examples](../modules/monitoring_alarm/EXAMPLES.md) | [Plan tests](../modules/monitoring_alarm/tests/basic.tftest.hcl) |
| [`network_security_group`](../modules/network_security_group/README.md) | Creates an OCI network security group and ingress or egress rules. | [Examples](../modules/network_security_group/EXAMPLES.md) | [Plan tests](../modules/network_security_group/tests/basic.tftest.hcl) |
| [`notification_topic`](../modules/notification_topic/README.md) | Creates an OCI Notifications topic and optional subscriptions. | [Examples](../modules/notification_topic/EXAMPLES.md) | [Plan tests](../modules/notification_topic/tests/basic.tftest.hcl) |
| [`object_storage`](../modules/object_storage/README.md) | Creates an OCI Object Storage bucket with private access and versioning enabled by default. | [Examples](../modules/object_storage/EXAMPLES.md) | [Plan tests](../modules/object_storage/tests/basic.tftest.hcl) |
| [`oke`](../modules/oke/README.md) | Creates an OKE cluster with a private Kubernetes API endpoint and optional managed worker pools. | [Examples](../modules/oke/EXAMPLES.md) | [Plan tests](../modules/oke/tests/basic.tftest.hcl) |
| [`queue`](../modules/queue/README.md) | Creates an OCI Queue with configurable retention, visibility, dead-letter delivery count, and optional customer-managed encryption. | [Examples](../modules/queue/EXAMPLES.md) | [Plan tests](../modules/queue/tests/basic.tftest.hcl) |
| [`route_table`](../modules/route_table/README.md) | Creates an OCI route table and optional internet or NAT gateways. | [Examples](../modules/route_table/EXAMPLES.md) | [Plan tests](../modules/route_table/tests/basic.tftest.hcl) |
| [`security_list`](../modules/security_list/README.md) | Creates an OCI security list and optional ingress or egress rules. | [Examples](../modules/security_list/EXAMPLES.md) | [Plan tests](../modules/security_list/tests/basic.tftest.hcl) |
| [`service_gateway`](../modules/service_gateway/README.md) | Creates an OCI service gateway for private VCN access to supported OCI services. | [Examples](../modules/service_gateway/EXAMPLES.md) | [Plan tests](../modules/service_gateway/tests/basic.tftest.hcl) |
| [`subnet`](../modules/subnet/README.md) | Creates one or more OCI subnets inside a VCN. | [Examples](../modules/subnet/EXAMPLES.md) | [Plan tests](../modules/subnet/tests/basic.tftest.hcl) |
| [`tag_default`](../modules/tag_default/README.md) | Creates one OCI tag default for a compartment and tag definition. | [Examples](../modules/tag_default/EXAMPLES.md) | [Plan tests](../modules/tag_default/tests/basic.tftest.hcl) |
| [`tag_namespace`](../modules/tag_namespace/README.md) | Creates an OCI defined-tag namespace and optional tag definitions. | [Examples](../modules/tag_namespace/EXAMPLES.md) | [Plan tests](../modules/tag_namespace/tests/basic.tftest.hcl) |
| [`vault`](../modules/vault/README.md) | Creates an OCI Vault for secrets and key-management foundations. | [Examples](../modules/vault/EXAMPLES.md) | [Plan tests](../modules/vault/tests/basic.tftest.hcl) |
| [`vault_secret`](../modules/vault_secret/README.md) | Stores a sensitive value as a base64-encoded OCI Vault secret using an existing Vault and symmetric KMS key. | [Examples](../modules/vault_secret/EXAMPLES.md) | [Plan tests](../modules/vault_secret/tests/basic.tftest.hcl) |
| [`vcn`](../modules/vcn/README.md) | Creates an OCI Virtual Cloud Network. | [Examples](../modules/vcn/EXAMPLES.md) | [Plan tests](../modules/vcn/tests/basic.tftest.hcl) |
| [`volume_backup_policy`](../modules/volume_backup_policy/README.md) | Creates a reusable user-defined block/boot volume backup policy with optional asset assignments. | [Examples](../modules/volume_backup_policy/EXAMPLES.md) | [Plan tests](../modules/volume_backup_policy/tests/basic.tftest.hcl) |

## Repository Guides

- [Root README](../README.md) and [root composition](ROOT_LEVEL_MODULES_GUIDE.md)
- [Cross-cloud coverage](PLATFORM_MODULE_COVERAGE.md) and [dependencies](MODULE_USAGE_AND_DEPENDENCIES.md)
- [Authoring standard](REPO_MODULES_GUIDE.md) and [contribution workflow](../CONTRIBUTING.md)
- [Security](../SECURITY.md), [hardening](HARDENING.md), and [migration](MIGRATION.md)
- [Pipeline](PIPELINE.md), [operations](OPERATIONS.md), and [validation](VALIDATION_SUMMARY.md)
- [Naming](NAMING_CONVENTION.md), [tagging](TAGGING_STANDARD.md), and [change record](../CHANGELOG.md)
