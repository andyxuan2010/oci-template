resource "oci_core_internet_gateway" "this" {
  count = var.enable_internet_gateway ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.display_name}-igw"
  enabled        = true
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_core_nat_gateway" "this" {
  count = var.enable_nat_gateway ? 1 : 0

  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = "${var.display_name}-nat"
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_core_route_table" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags

  dynamic "route_rules" {
    for_each = var.route_rules
    content {
      destination       = route_rules.value.destination
      destination_type  = try(route_rules.value.destination_type, "CIDR_BLOCK")
      network_entity_id = coalesce(lookup(local.network_entity_ids, route_rules.value.network_entity, null), route_rules.value.network_entity)
      description       = try(route_rules.value.description, null)
    }
  }
}
