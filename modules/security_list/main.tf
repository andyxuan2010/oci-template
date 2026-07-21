resource "oci_core_security_list" "this" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.display_name
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags

  dynamic "ingress_security_rules" {
    for_each = var.ingress_rules
    content {
      protocol    = ingress_security_rules.value.protocol
      source      = ingress_security_rules.value.source
      source_type = try(ingress_security_rules.value.source_type, "CIDR_BLOCK")
      stateless   = try(ingress_security_rules.value.stateless, false)
      description = try(ingress_security_rules.value.description, null)

      dynamic "tcp_options" {
        for_each = try(ingress_security_rules.value.tcp_options, null) == null ? [] : [ingress_security_rules.value.tcp_options]
        content {
          min = tcp_options.value.min
          max = tcp_options.value.max
        }
      }

      dynamic "udp_options" {
        for_each = try(ingress_security_rules.value.udp_options, null) == null ? [] : [ingress_security_rules.value.udp_options]
        content {
          min = udp_options.value.min
          max = udp_options.value.max
        }
      }

      dynamic "icmp_options" {
        for_each = try(ingress_security_rules.value.icmp_options, null) == null ? [] : [ingress_security_rules.value.icmp_options]
        content {
          type = icmp_options.value.type
          code = try(icmp_options.value.code, null)
        }
      }
    }
  }

  dynamic "egress_security_rules" {
    for_each = var.egress_rules
    content {
      protocol         = egress_security_rules.value.protocol
      destination      = egress_security_rules.value.destination
      destination_type = try(egress_security_rules.value.destination_type, "CIDR_BLOCK")
      stateless        = try(egress_security_rules.value.stateless, false)
      description      = try(egress_security_rules.value.description, null)

      dynamic "tcp_options" {
        for_each = try(egress_security_rules.value.tcp_options, null) == null ? [] : [egress_security_rules.value.tcp_options]
        content {
          min = tcp_options.value.min
          max = tcp_options.value.max
        }
      }

      dynamic "udp_options" {
        for_each = try(egress_security_rules.value.udp_options, null) == null ? [] : [egress_security_rules.value.udp_options]
        content {
          min = udp_options.value.min
          max = udp_options.value.max
        }
      }

      dynamic "icmp_options" {
        for_each = try(egress_security_rules.value.icmp_options, null) == null ? [] : [egress_security_rules.value.icmp_options]
        content {
          type = icmp_options.value.type
          code = try(icmp_options.value.code, null)
        }
      }
    }
  }
}
