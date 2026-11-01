resource "oci_core_subnet" "this" {
  for_each = var.subnets

  compartment_id             = var.compartment_id
  vcn_id                     = var.vcn_id
  display_name               = each.key
  cidr_block                 = each.value.cidr_block
  dns_label                  = each.value.dns_label
  prohibit_public_ip_on_vnic = each.value.prohibit_public_ip_on_vnic
  security_list_ids          = length(each.value.security_list_ids) > 0 ? each.value.security_list_ids : var.default_security_list_ids
  route_table_id             = each.value.route_table_id != null ? each.value.route_table_id : var.default_route_table_id
  freeform_tags              = var.freeform_tags
  defined_tags               = var.defined_tags
}
