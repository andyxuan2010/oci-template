# service_gateway Examples

## Basic Composition

```hcl
module "service_gateway" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/service_gateway"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  vcn_id         = "ocid1.vcn.oc1.iad.exampleuniqueid"
  display_name   = "sgw-app-dev"
  services = [
    {
      service_id = "ocid1.service.oc1.iad.exampleuniqueid"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Select OCI service IDs offered in the target region. Service gateways do not install subnet routes automatically; connect the gateway output to route rules and apply appropriate network controls.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
