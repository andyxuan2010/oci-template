# OCI Load Balancer Module

Creates an OCI load balancer with optional backend sets, backends, and listeners.

## Usage

Use this for private or public service front ends; default examples keep it private.

```hcl
module "load_balancer" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/load_balancer"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  display_name = "lb-app-dev"
  subnet_ids = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  is_private = true
  network_security_group_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  backend_sets = {
    app = {
      policy = "ROUND_ROBIN"
      health_checker = {
        protocol = "HTTP"
        port = 80
        url_path = "/"
        return_code = 200
      }
    }
  }
  backends = {
    app01 = {
      backend_set_name = "app"
      ip_address = "10.20.1.10"
      port = 80
    }
  }
  listeners = {
    http = {
      default_backend_set_name = "app"
      port = 80
      protocol = "HTTP"
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Compartment OCID. |
| `display_name` | `string` | Yes | Load balancer display name. |
| `shape` | `string` | No | Load balancer shape. |
| `minimum_bandwidth_in_mbps` | `number` | No | Minimum bandwidth for flexible shape. |
| `maximum_bandwidth_in_mbps` | `number` | No | Maximum bandwidth for flexible shape. |
| `subnet_ids` | `list(string)` | Yes | Subnet OCIDs for the load balancer. |
| `is_private` | `bool` | No | Whether the load balancer is private. |
| `network_security_group_ids` | `list(string)` | No | NSG OCIDs attached to the load balancer. |
| `backend_sets` | `complex` | No | Backend set definitions keyed by backend set name. |
| `backends` | `complex` | No | Backend definitions keyed by logical name. |
| `listeners` | `complex` | No | Listener definitions keyed by listener name. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Load balancer OCID. |
| `ip_address_details` | Load balancer IP address details. |
| `backend_set_names` | Backend set names. |
| `listener_names` | Listener names. |

## Examples

See [EXAMPLES.md](./EXAMPLES.md) for a complete example.

## Terraform Tests

This module includes a mock-provider plan test at [tests/basic.tftest.hcl](./tests/basic.tftest.hcl). Run it from the module directory:

```powershell
terraform init -backend=false
terraform test
```

The repository-level validation helper also validates module syntax:

```powershell
.\test.ps1 modules\load_balancer\main.tf
```
