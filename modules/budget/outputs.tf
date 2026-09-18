output "id" {
  description = "Budget OCID."
  value       = oci_budget_budget.this.id
}

output "alert_rule_ids" {
  description = "Budget alert rule OCIDs keyed by rule name."
  value       = { for name, rule in oci_budget_alert_rule.this : name => rule.id }
}
