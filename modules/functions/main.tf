resource "oci_functions_application" "this" {
  compartment_id             = var.compartment_id
  display_name               = var.display_name
  subnet_ids                 = var.subnet_ids
  network_security_group_ids = var.network_security_group_ids
  config                     = var.config
  freeform_tags              = var.freeform_tags
  defined_tags               = var.defined_tags
}

resource "oci_functions_function" "this" {
  for_each           = var.functions
  application_id     = oci_functions_application.this.id
  display_name       = each.key
  image              = each.value.image
  memory_in_mbs      = each.value.memory_in_mbs
  timeout_in_seconds = each.value.timeout_in_seconds
  config             = each.value.config
  freeform_tags      = var.freeform_tags
  defined_tags       = var.defined_tags
}
