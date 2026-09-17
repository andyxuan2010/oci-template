# Logging Examples

```hcl
module "logging" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/logging"

  compartment_id = var.compartment_id
  display_name   = "logs-platform-dev"
  description    = "Landing-zone service logs"

  logs = {
    vcn_flow = {
      display_name       = "vcn-flow-platform-dev"
      retention_duration = 30
      configuration = {
        category = "all"
        resource = module.vcn.id
        service  = "flowlogs"
      }
    }
  }
}
```
