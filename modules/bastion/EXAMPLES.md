# Bastion Examples

```hcl
module "bastion" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/bastion"

  compartment_id   = var.compartment_id
  target_subnet_id = module.subnet.ids["private"]
  name             = "bastion-platform-dev"
  client_cidr_block_allow_list = [
    "203.0.113.10/32"
  ]
  max_session_ttl_in_seconds = 3600
}
```
