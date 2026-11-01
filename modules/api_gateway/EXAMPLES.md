# api_gateway Examples

## Basic Composition

```hcl
module "api_gateway" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/api_gateway"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name   = "apigw-app-dev"
  subnet_id      = "ocid1.subnet.oc1.iad.exampleuniqueid"
  deployments = {
    app = {
      path_prefix = "/app"
      routes      = { health = { path = "/health", url = "https://backend.internal.example.com/health" } }
    }
  }
  freeform_tags = { environment = "dev", managed_by = "terraform" }
}
```

## Deployment Notes

Provide subnet routing, DNS resolution, and NSG rules for clients and HTTPS backends. Built-in deployments support HTTP backends without gateway authentication policies; restrict network access and enforce application authentication. For JWT authorization, custom certificates, Functions backends, or usage plans, leave `deployments = {}` and manage `oci_apigateway_deployment` separately using the gateway ID. Set `endpoint_type = "PUBLIC"` only with an appropriate public subnet and access design.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
