# load_balancer

Creates an OCI load balancer with optional backend sets, backends, and listeners.

## Usage

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

## Security and Operations

Load balancers are private by default. TLS listener blocks support existing certificate names or OCI Certificates OCIDs and allow only TLSv1.2/TLSv1.3. Listener `verify_peer_certificate` controls client-certificate verification (mTLS), not backend TLS. Existing certificate names must belong to this load balancer. HTTP and TCP listeners remain available; caller-owned network controls and application/backend encryption must match the workload. Backends and listeners must reference backend sets managed by this module.

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
| [oci_load_balancer_backend.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/load_balancer_backend) | resource |
| [oci_load_balancer_backend_set.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/load_balancer_backend_set) | resource |
| [oci_load_balancer_listener.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/load_balancer_listener) | resource |
| [oci_load_balancer_load_balancer.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/load_balancer_load_balancer) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_sets | Backend set definitions keyed by backend set name. | <pre>map(object({<br>    policy = optional(string, "ROUND_ROBIN")<br>    health_checker = object({<br>      protocol            = string<br>      port                = number<br>      url_path            = optional(string)<br>      return_code         = optional(number)<br>      retries             = optional(number)<br>      timeout_in_millis   = optional(number)<br>      interval_ms         = optional(number)<br>      response_body_regex = optional(string)<br>    })<br>  }))</pre> | `{}` | no |
| backends | Backend definitions keyed by logical name. | <pre>map(object({<br>    backend_set_name = string<br>    ip_address       = string<br>    port             = number<br>    backup           = optional(bool, false)<br>    drain            = optional(bool, false)<br>    offline          = optional(bool, false)<br>    weight           = optional(number, 1)<br>  }))</pre> | `{}` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Load balancer display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| is\_private | Whether the load balancer is private. | `bool` | `true` | no |
| listeners | Listener definitions keyed by listener name. | <pre>map(object({<br>    default_backend_set_name = string<br>    port                     = number<br>    protocol                 = string<br>    hostname_names           = optional(list(string), [])<br>    path_route_set_name      = optional(string)<br>    rule_set_names           = optional(list(string), [])<br>    ssl_configuration = optional(object({<br>      certificate_name        = optional(string)<br>      certificate_ids         = optional(list(string), [])<br>      protocols               = optional(list(string), ["TLSv1.2"])<br>      verify_peer_certificate = optional(bool, false)<br>    }))<br>  }))</pre> | `{}` | no |
| maximum\_bandwidth\_in\_mbps | Maximum bandwidth for flexible shape. | `number` | `100` | no |
| minimum\_bandwidth\_in\_mbps | Minimum bandwidth for flexible shape. | `number` | `10` | no |
| network\_security\_group\_ids | NSG OCIDs attached to the load balancer. | `list(string)` | `[]` | no |
| shape | Load balancer shape. | `string` | `"flexible"` | no |
| subnet\_ids | Subnet OCIDs for the load balancer. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backend\_set\_names | Backend set names. |
| id | Load balancer OCID. |
| ip\_address\_details | Load balancer IP address details. |
| listener\_names | Listener names. |
<!-- END_TF_DOCS -->
