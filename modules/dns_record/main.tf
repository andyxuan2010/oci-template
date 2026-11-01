data "oci_dns_zone" "this" {
  zone_name_or_id = var.zone_id
  scope           = var.scope
}

resource "oci_dns_rrset" "this" {
  zone_name_or_id = data.oci_dns_zone.this.id
  domain          = var.domain
  rtype           = upper(var.rtype)
  dynamic "items" {
    for_each = toset(var.records)
    content {
      domain = var.domain
      rtype  = upper(var.rtype)
      ttl    = var.ttl
      rdata  = items.value
    }
  }
}
