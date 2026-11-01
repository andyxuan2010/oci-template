# network_security_group Examples

## Basic Composition

```hcl
module "network_security_group" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/network_security_group"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "nsg-app-dev"
  ingress_rules = [
    {
      protocol = "6"
      source   = "10.20.0.0/16"
      tcp_options = {
        min = 22
        max = 22
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

Ingress and egress default to empty lists. IPv4/IPv6 /0 ingress to SSH, RDP, WinRM, unrestricted TCP/UDP management ranges, or all protocols is rejected unless `allow_unrestricted_management_ingress = true`. This exception is a risk acceptance setting, not an IAM approval. Public HTTPS rules remain supported. Rule list order determines existing Terraform addresses; preserve it when changing rules.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
