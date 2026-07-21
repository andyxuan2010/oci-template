# Compartment Quota Examples

```hcl
module "compartment_quota" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/compartment_quota"

  compartment_id = var.tenancy_ocid
  name           = "quota-platform-dev"
  description    = "Prevent unapproved development capacity"
  statements = [
    "zero compute-core quotas in compartment platform-dev",
    "set compute-core quota standard-a1-core-count to 4 in compartment platform-dev"
  ]
}
```
