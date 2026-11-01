# security_list Examples

## Basic Composition

```hcl
module "security_list" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/security_list"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "sl-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source   = "10.20.0.0/16"
      tcp_options = {
        min = 2049
        max = 2049
      }
    }
  ]
  egress_rules = [
    {
      protocol    = "all"
      destination = "0.0.0.0/0"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Ingress and egress default to empty lists. World-accessible SSH/RDP/WinRM and all-protocol ingress require `allow_unrestricted_management_ingress = true`. Prefer NSGs for workload rules. The root uses an empty instance of this module to avoid inheriting OCI default-list rules.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
