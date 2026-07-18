resource "oci_core_drg" "this" {
  compartment_id = var.compartment_id
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_core_drg_attachment" "vcn" {
  for_each = var.vcn_attachments

  drg_id                           = oci_core_drg.this.id
  vcn_id                           = each.value.vcn_id
  display_name                     = coalesce(try(each.value.display_name, null), each.key)
  drg_route_table_id               = try(each.value.drg_route_table_id, null)
  route_table_id                   = try(each.value.route_table_id, null)
  export_drg_route_distribution_id = try(each.value.export_drg_route_distribution_id, null)
  freeform_tags                    = var.freeform_tags
  defined_tags                     = var.defined_tags
}
