# load_balancer Examples

## Basic Example

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

## Notes

- Replace example OCIDs and names with values from the target OCI tenancy.
- Keep `freeform_tags` and `defined_tags` consistent with the root tagging standard.
- Run `terraform plan` before applying in a live tenancy.
