resource "oci_bastion_bastion" "this" {
  compartment_id                = var.compartment_id
  target_subnet_id              = var.target_subnet_id
  bastion_type                  = var.bastion_type
  name                          = var.name
  client_cidr_block_allow_list  = var.client_cidr_block_allow_list
  max_session_ttl_in_seconds    = var.max_session_ttl_in_seconds
  dns_proxy_status              = var.dns_proxy_status
  static_jump_host_ip_addresses = var.static_jump_host_ip_addresses
  freeform_tags                 = var.freeform_tags
  defined_tags                  = var.defined_tags
}
