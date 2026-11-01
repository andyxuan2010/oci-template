locals {
  management_ingress_is_restricted = alltrue([for rule in var.ingress_rules : !(rule.source_type == "CIDR_BLOCK" && try(tonumber(split("/", rule.source)[1]) == 0, false) && (
    rule.protocol == "all" ||
    (rule.protocol == "6" && (rule.tcp_options == null ? true : anytrue([for port in [22, 3389, 5985, 5986] : rule.tcp_options.min <= port && rule.tcp_options.max >= port]))) ||
    (rule.protocol == "17" && (rule.udp_options == null ? true : rule.udp_options.min <= 3389 && rule.udp_options.max >= 3389))
  ))])
}
