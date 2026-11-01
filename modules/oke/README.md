# oke

Creates an OKE cluster with a private Kubernetes API endpoint and optional managed worker pools.

## Usage

```hcl
module "oke" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/oke"

  compartment_id     = "ocid1.compartment.oc1..exampleuniqueid"
  name               = "oke-app-dev"
  vcn_id             = "ocid1.vcn.oc1.iad.exampleuniqueid"
  kubernetes_version = var.kubernetes_version
  endpoint_subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  node_pools = {
    app = {
      image_id = "ocid1.image.oc1.iad.exampleuniqueid"
      placements = {
        ad1 = { availability_domain = "example:US-ASHBURN-AD-1", subnet_id = "ocid1.subnet.oc1.iad.workerexample" }
      }
    }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Security and Operations

Declare `kubernetes_version` as a string variable in the caller and select a version and worker image offered in the target region. This module uses a BASIC cluster and Flannel overlay networking; it supports managed Flex worker pools, not virtual nodes or VCN-native pod networking. Provide private endpoint and worker subnets, required OKE NSG/security rules, IAM permissions, and registry/OCI service egress before applying. The module cannot inspect subnet privacy. With `node_pools = {}` only the control plane is created. Access the private API from an authorized network or Bastion; kubeconfig generation and Kubernetes workloads are managed separately.

Authentication is supplied by the calling configuration; this module declares no provider credentials. Taggable resources accept caller-owned `freeform_tags` and `defined_tags`. See [EXAMPLES.md](EXAMPLES.md), the [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).

## Validation

From this module directory:

```powershell
terraform init -backend=false
terraform validate
terraform test
```

[tests/basic.tftest.hcl](tests/basic.tftest.hcl) runs mock-provider plans without OCI credentials or creating resources. Live service availability, permissions, quotas, and network connectivity require a target-tenancy plan.

## Generated Reference

The tables below are generated from Terraform using `scripts/Update-ModuleDocs.ps1`; do not edit them manually.

## Testing

Run the module tests from this directory:

```sh
terraform init -backend=false
terraform test
```

The test files are in [tests](tests).

## Examples

- [Basic](examples/basic): minimal configuration.
- [Complete](examples/complete): every optional input set.

## Providers

| Name | Source | Version |
| --- | --- | --- |
| oci | oracle/oci | >= 8.23.0, < 9.0.0 |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7.0 |
| oci | >= 8.23.0, < 9.0.0 |

## Resources

| Name | Type |
|------|------|
| [oci_containerengine_cluster.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_cluster) | resource |
| [oci_containerengine_node_pool.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/containerengine_node_pool) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| endpoint\_nsg\_ids | NSGs for the Kubernetes API endpoint. | `list(string)` | `[]` | no |
| endpoint\_subnet\_id | Private subnet OCID for the Kubernetes API endpoint. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| kms\_key\_id | Optional KMS key OCID for Kubernetes secrets. | `string` | `null` | no |
| kubernetes\_version | Region-supported Kubernetes version; select explicitly. | `string` | n/a | yes |
| name | Cluster name. | `string` | n/a | yes |
| node\_pools | Managed Flex worker pools with explicit compatible images and private subnet placements. | <pre>map(object({<br>    node_shape     = optional(string, "VM.Standard.E5.Flex")<br>    ocpus          = optional(number, 1)<br>    memory_in_gbs  = optional(number, 16)<br>    image_id       = string<br>    size           = optional(number, 1)<br>    nsg_ids        = optional(list(string), [])<br>    ssh_public_key = optional(string)<br>    placements = map(object({<br>      availability_domain = string<br>      subnet_id           = string<br>    }))<br>  }))</pre> | `{}` | no |
| vcn\_id | Cluster VCN OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoints | Cluster API endpoints. |
| id | OKE cluster OCID. |
| node\_pool\_ids | Managed worker pool OCIDs keyed by logical name. |
<!-- END_TF_DOCS -->
