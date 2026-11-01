resource "oci_core_network_security_group" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags

  lifecycle {
    precondition {
      condition     = var.allow_unrestricted_management_ingress || local.management_ingress_is_restricted
      error_message = "World-accessible management ports or all-protocol ingress require an explicit exception. Restrict the source CIDR instead."
    }
  }

}

resource "oci_core_network_security_group_security_rule" "ingress" {
  for_each = { for index, rule in var.ingress_rules : index => rule }

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "INGRESS"
  protocol                  = each.value.protocol
  source                    = each.value.source
  source_type               = each.value.source_type
  stateless                 = each.value.stateless
  description               = each.value.description

  dynamic "tcp_options" {
    for_each = each.value.tcp_options == null ? [] : [each.value.tcp_options]
    content {
      destination_port_range {
        min = tcp_options.value.min
        max = tcp_options.value.max
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.udp_options == null ? [] : [each.value.udp_options]
    content {
      destination_port_range {
        min = udp_options.value.min
        max = udp_options.value.max
      }
    }
  }

  dynamic "icmp_options" {
    for_each = each.value.icmp_options == null ? [] : [each.value.icmp_options]
    content {
      type = icmp_options.value.type
      code = icmp_options.value.code
    }
  }
}

resource "oci_core_network_security_group_security_rule" "egress" {
  for_each = { for index, rule in var.egress_rules : index => rule }

  network_security_group_id = oci_core_network_security_group.this.id
  direction                 = "EGRESS"
  protocol                  = each.value.protocol
  destination               = each.value.destination
  destination_type          = each.value.destination_type
  stateless                 = each.value.stateless
  description               = each.value.description

  dynamic "tcp_options" {
    for_each = each.value.tcp_options == null ? [] : [each.value.tcp_options]
    content {
      destination_port_range {
        min = tcp_options.value.min
        max = tcp_options.value.max
      }
    }
  }

  dynamic "udp_options" {
    for_each = each.value.udp_options == null ? [] : [each.value.udp_options]
    content {
      destination_port_range {
        min = udp_options.value.min
        max = udp_options.value.max
      }
    }
  }

  dynamic "icmp_options" {
    for_each = each.value.icmp_options == null ? [] : [each.value.icmp_options]
    content {
      type = icmp_options.value.type
      code = icmp_options.value.code
    }
  }
}
