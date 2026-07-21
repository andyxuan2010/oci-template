# Budget Examples

```hcl
module "budget" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/budget"

  compartment_id        = var.tenancy_ocid
  targets               = [var.workload_compartment_id]
  display_name          = "budget-platform-dev"
  amount                = 10

  alert_rules = {
    eighty_percent = {
      threshold  = 80
      recipients = "platform@example.com"
      message    = "The development budget reached 80 percent."
    }
    forecast = {
      threshold  = 100
      type       = "FORECAST"
      recipients = "platform@example.com"
    }
  }
}
```
