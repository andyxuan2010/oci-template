# oke Examples

## Basic Composition

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

## Deployment Notes

Declare `kubernetes_version` as a string variable in the caller and select a version and worker image offered in the target region. This module uses a BASIC cluster and Flannel overlay networking; it supports managed Flex worker pools, not virtual nodes or VCN-native pod networking. Provide private endpoint and worker subnets, required OKE NSG/security rules, IAM permissions, and registry/OCI service egress before applying. The module cannot inspect subnet privacy. With `node_pools = {}` only the control plane is created. Access the private API from an authorized network or Bastion; kubeconfig generation and Kubernetes workloads are managed separately.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
