resource "oci_budget_budget" "this" {
  compartment_id         = var.compartment_id
  amount                 = var.amount
  reset_period           = var.reset_period
  display_name           = var.display_name
  description            = var.description
  target_type            = var.target_type
  targets                = var.targets
  processing_period_type = var.processing_period_type
  start_date             = var.start_date
  end_date               = var.end_date
  freeform_tags          = var.freeform_tags
  defined_tags           = var.defined_tags
}

resource "oci_budget_alert_rule" "this" {
  for_each = var.alert_rules

  budget_id      = oci_budget_budget.this.id
  threshold      = each.value.threshold
  threshold_type = each.value.threshold_type
  type           = each.value.type
  recipients     = each.value.recipients
  display_name   = coalesce(each.value.display_name, each.key)
  description    = each.value.description
  message        = each.value.message
  freeform_tags  = var.freeform_tags
  defined_tags   = var.defined_tags
}
