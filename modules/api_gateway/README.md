# api_gateway

Creates a private API Gateway with optional HTTP backend deployments.

## Usage

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

## Security and Operations

Provide subnet routing, DNS resolution, and NSG rules for clients and HTTPS backends. Built-in deployments support HTTP backends without gateway authentication policies; restrict network access and enforce application authentication. For JWT authorization, custom certificates, Functions backends, or usage plans, leave `deployments = {}` and manage `oci_apigateway_deployment` separately using the gateway ID. Set `endpoint_type = "PUBLIC"` only with an appropriate public subnet and access design.

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
| [oci_apigateway_deployment.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/apigateway_deployment) | resource |
| [oci_apigateway_gateway.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/apigateway_gateway) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| deployments | HTTP backend deployments keyed by stable logical name. | <pre>map(object({<br>    path_prefix = string<br>    routes = map(object({<br>      path    = string<br>      methods = optional(list(string), ["GET"])<br>      url     = string<br>    }))<br>  }))</pre> | `{}` | no |
| display\_name | Gateway display name. | `string` | n/a | yes |
| endpoint\_type | PRIVATE or PUBLIC gateway endpoint. | `string` | `"PRIVATE"` | no |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| network\_security\_group\_ids | Gateway NSG OCIDs. | `list(string)` | `[]` | no |
| subnet\_id | Gateway subnet OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| deployment\_endpoints | Deployment URLs keyed by logical name. |
| deployment\_ids | Deployment OCIDs keyed by logical name. |
| hostname | Gateway hostname. |
| id | Gateway OCID. |
<!-- END_TF_DOCS -->
