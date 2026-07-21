resource "oci_identity_tag_namespace" "this" {
  compartment_id = var.compartment_id
  name           = var.name
  description    = var.description
  is_retired     = var.is_retired
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}

resource "oci_identity_tag" "this" {
  for_each = var.tags

  tag_namespace_id = oci_identity_tag_namespace.this.id
  name             = each.key
  description      = each.value.description
  is_cost_tracking = each.value.is_cost_tracking
  is_retired       = each.value.is_retired
  freeform_tags    = var.freeform_tags
  defined_tags     = var.defined_tags

  dynamic "validator" {
    for_each = each.value.validator == null ? [] : [each.value.validator]
    content {
      validator_type = validator.value.validator_type
      values         = validator.value.values
    }
  }
}
