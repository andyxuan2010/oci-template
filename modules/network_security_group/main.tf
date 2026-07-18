resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_core_network_security_group_security_rule" "ingress" {
  for_each = { for index, rule in var.ingress_rules : index => rule }

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "INGRESS"
  protocol                  = each.value.protocol
  source                    = each.value.source
  source_type               = try(each.value.source_type, "CIDR_BLOCK")
  stateless                 = try(each.value.stateless, false)
  description               = try(each.value.description, null)

  dynamic "tcp_options" {
    for_each = try(each.value.tcp_options, null) == null ? [] : [each.value.tcp_options]
    content {
      destination_port_range {
        min = tcp_options.value.min
        max = tcp_options.value.max
      }
    }
  }

  dynamic "udp_options" {
    for_each = try(each.value.udp_options, null) == null ? [] : [each.value.udp_options]
    content {
      destination_port_range {
        min = udp_options.value.min
        max = udp_options.value.max
      }
    }
  }

  dynamic "icmp_options" {
    for_each = try(each.value.icmp_options, null) == null ? [] : [each.value.icmp_options]
    content {
      type = icmp_options.value.type
      code = try(icmp_options.value.code, null)
    }
  }
}

resource "oci_core_network_security_group_security_rule" "egress" {
  for_each = { for index, rule in var.egress_rules : index => rule }

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "EGRESS"
  protocol                  = each.value.protocol
  destination               = each.value.destination
  destination_type          = try(each.value.destination_type, "CIDR_BLOCK")
  stateless                 = try(each.value.stateless, false)
  description               = try(each.value.description, null)

  dynamic "tcp_options" {
    for_each = try(each.value.tcp_options, null) == null ? [] : [each.value.tcp_options]
    content {
      destination_port_range {
        min = tcp_options.value.min
        max = tcp_options.value.max
      }
    }
  }

  dynamic "udp_options" {
    for_each = try(each.value.udp_options, null) == null ? [] : [each.value.udp_options]
    content {
      destination_port_range {
        min = udp_options.value.min
        max = udp_options.value.max
      }
    }
  }

  dynamic "icmp_options" {
    for_each = try(each.value.icmp_options, null) == null ? [] : [each.value.icmp_options]
    content {
      type = icmp_options.value.type
      code = try(icmp_options.value.code, null)
    }
  }
}
