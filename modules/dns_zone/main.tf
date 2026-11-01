resource "oci_dns_zone" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  zone_type      = var.zone_type
  scope          = var.scope
  view_id        = var.view_id
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
