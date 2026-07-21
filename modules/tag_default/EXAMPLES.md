# Tag Default Examples

```hcl
module "environment_tag_default" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/tag_default"

  compartment_id   = var.compartment_id
  tag_definition_id = module.governance_tags.tag_ids["Environment"]
  value              = "dev"
  is_required        = true
}
```
