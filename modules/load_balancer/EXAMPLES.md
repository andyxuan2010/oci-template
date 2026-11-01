# load_balancer Examples

## Basic Composition

```hcl
module "load_balancer" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/load_balancer"

  compartment_id             = "ocid1.compartment.oc1..exampleuniqueid"
  display_name               = "lb-app-dev"
  subnet_ids                 = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  is_private                 = true
  network_security_group_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  backend_sets = {
    app = {
      policy = "ROUND_ROBIN"
      health_checker = {
        protocol    = "HTTP"
        port        = 80
        url_path    = "/"
        return_code = 200
      }
    }
  }
  backends = {
    app01 = {
      backend_set_name = "app"
      ip_address       = "10.20.1.10"
      port             = 80
    }
  }
  listeners = {
    http = {
      default_backend_set_name = "app"
      port                     = 80
      protocol                 = "HTTP"
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Load balancers are private by default. TLS listener blocks support existing certificate names or OCI Certificates OCIDs and allow only TLSv1.2/TLSv1.3. Listener `verify_peer_certificate` controls client-certificate verification (mTLS), not backend TLS. Existing certificate names must belong to this load balancer. HTTP and TCP listeners remain available; caller-owned network controls and application/backend encryption must match the workload. Backends and listeners must reference backend sets managed by this module.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
