# OCI Platform Module Coverage

## Inventory and Selection

The OCI repository already supplied 26 modules for compartments, VCNs, routing and gateways, network controls, compute, block/file/object storage, load balancing, DNS zones, Vault/KMS, IAM, monitoring, logging, budgets, tagging, quotas, notifications, and Bastion. These existing capabilities remain reusable without duplicate gateway, bucket, logging, or IAM modules.

Ten common gaps were selected by inspecting the local sibling `azure-template/modules` and `aws-template/modules` inventories and the existing OCI module contracts. The resulting inventory contains **36 modules**. This comparison describes available repository modules, not feature equivalence between cloud services or a claim that every workload needs every module.

| Added OCI module | Platform capability | Azure sibling coverage | AWS sibling coverage |
| --- | --- | --- | --- |
| [`oke`](../modules/oke/README.md) | Managed Kubernetes control plane and optional worker pools | `aks` | `No dedicated EKS module; ec2_instance is VM compute` |
| [`container_repository`](../modules/container_repository/README.md) | Private container image repository | `acr` | `ecr_repository` |
| [`autonomous_database`](../modules/autonomous_database/README.md) | Private managed relational database | `sqldb / sqlmi (capability analogue)` | `rds (capability analogue)` |
| [`vault_secret`](../modules/vault_secret/README.md) | Secret values and versions in an existing Vault | `keyvault` | `secrets_manager` |
| [`api_gateway`](../modules/api_gateway/README.md) | Private API ingress and optional HTTPS backend routes | `applicationgateway covers HTTP ingress; no API Management module` | `api_gateway` |
| [`functions`](../modules/functions/README.md) | Serverless application and container-image functions | `functionapp / functionappflex` | `lambda_function` |
| [`queue`](../modules/queue/README.md) | Asynchronous messaging with built-in dead-letter handling | `servicebus` | `sqs_queue` |
| [`events_rule`](../modules/events_rule/README.md) | OCI service event filtering and routing | `eventgridsystemtopic` | `eventbridge` |
| [`volume_backup_policy`](../modules/volume_backup_policy/README.md) | Custom backup schedules and optional volume assignments | `recovery_services_vault (backup capability)` | `aws_backup` |
| [`dns_record`](../modules/dns_record/README.md) | Private or public DNS record set | `private_dns` | `route53` |

`autonomous_database` provides an Oracle managed database rather than emulating SQL Server or RDS engines. `volume_backup_policy` targets OCI block/boot volumes and volume groups rather than all backup services. API Gateway supports gateway creation and basic HTTP deployments; advanced authentication policies remain caller-owned. OKE fills a Kubernetes gap visible in Azure even though the AWS sibling currently has no dedicated EKS module.

## Dependencies and Ownership

| Module | Prerequisites |
| --- | --- |
| `oke` | Compartment, VCN, private API subnet, region-supported Kubernetes version; worker image and placements when enabled |
| `container_repository` | Compartment; IAM and external image build/push pipeline |
| `autonomous_database` | Compartment, private subnet, sensitive ADMIN password; client NSGs and DNS |
| `vault_secret` | Compartment, vault, symmetric KMS key, sensitive secret value |
| `api_gateway` | Compartment, subnet; backend DNS, routing and NSGs for deployments |
| `functions` | Compartment, private subnets; images, registry permissions and service egress for functions |
| `queue` | Compartment; producer/consumer IAM and optional KMS key |
| `events_rule` | Compartment, JSON condition, Notifications/Functions/Streaming destination and delivery IAM |
| `volume_backup_policy` | Compartment; existing block/boot volume or volume group OCIDs for optional assignments |
| `dns_record` | Existing DNS zone OCID, domain, type and record values |

Useful composition chains:

- `compartment` -> `vcn` -> `subnet` + `network_security_group` -> `oke`, `autonomous_database`, `api_gateway`, or `functions`.
- `container_repository` -> external build/push pipeline -> `functions` or Kubernetes workloads on `oke`.
- `vault` -> `kms_key` -> `vault_secret`; `queue` can also use a customer-managed key.
- `notification_topic` or `functions` -> `events_rule`; Streaming destinations can be supplied by OCID.
- `volume_backup_policy.id` -> `block_volume.backup_policy_id`, or assign existing assets through `volume_backup_policy.asset_ids`. Use one assignment owner per asset.
- `dns_zone.id` -> `dns_record.zone_id`. One caller owns the full zone/domain/type record set.

Creating a resource does not grant IAM permissions to its consumers. Use the existing `dynamic_group` and `iam_policy` modules for resource-principal access and OCI service delivery policies. Use `logging`, `monitoring_alarm`, `notification_topic`, and `budget` where appropriate for operations.

## Alignment with the Sibling Templates

Each addition follows the existing module layout: `versions.tf`, `variables.tf`, `main.tf`, `outputs.tf`, `README.md`, `EXAMPLES.md`, and `tests/basic.tftest.hcl`. Inputs are typed, repeatable child resources use maps with stable keys, externally managed resources are passed as OCIDs, and taggable resources accept `freeform_tags` and `defined_tags`. DNS RRSets and backup assignments do not support tags themselves.

All 36 modules declare Terraform >= 1.7.0 and OCI provider >= 8.23.0, < 9.0.0. The minimum Terraform version supports mock-provider tests; the provider range matches the schema used for validation and excludes an unreviewed major upgrade. The root requires Terraform >= 1.12.0 and CI uses 1.15.8.

The root sample now composes nine baseline modules, including a managed empty security list. Additions are opt-in library modules: OKE workers, Functions images, API deployments, and backup asset assignments are independently optional. Selecting a module requires an explicit module call; adding this library creates no additional resources in the root configuration.

## Defaults and Limits

- OKE API endpoints, Autonomous Database endpoints, API Gateway endpoints, container repositories, and DNS record scopes default to private access. OKE and Functions callers must select private subnets and supply routing/NSG rules.
- OKE versions and worker images are explicit region-specific inputs. Image builds, kubeconfig generation, and Kubernetes workload deployment are separate steps.
- Queue enables built-in dead-letter handling by default. Event rules support Notifications, Functions, and Streaming destinations, not Queue directly.
- Database passwords and Vault secret content are sensitive inputs with no secret outputs. Terraform state still contains their values and must be encrypted and access-controlled.
- Database backups/disaster recovery, secret rotation, advanced API authorization, and image supply-chain policies require workload-specific design beyond these modules.
- Examples use illustrative OCIDs and images. Mock tests establish configuration behavior; they do not prove tenancy permissions, regional availability, network connectivity, or live service acceptance.

See the [module index](MODULES_INDEX.md), per-module examples, and [validation results](VALIDATION_SUMMARY.md) before composing a workload.


The later [hardening review](HARDENING.md) standardized the complete library and refreshed all references/examples. See [migration notes](MIGRATION.md) for changed defaults and [CHANGELOG.md](../CHANGELOG.md) for the work record.
