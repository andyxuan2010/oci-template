# Tag Namespace Examples

```hcl
module "governance_tags" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/tag_namespace"

  compartment_id = var.tenancy_ocid
  name           = "Governance"
  description    = "Landing-zone governance tags"

  tags = {
    Environment = {
      description      = "Deployment environment"
      is_cost_tracking = true
      validator = {
        validator_type = "ENUM"
        values         = ["dev", "sandbox", "prod"]
      }
    }
    Owner = {
      description = "Owning team"
    }
  }
}
```
