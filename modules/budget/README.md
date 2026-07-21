# OCI Budget Module

Creates an OCI budget and optional alert rules for a compartment or tag target.

Required inputs are `compartment_id`, `amount`, `display_name`, and `targets`.
Alert-rule recipients are supplied as a comma-separated email string.

Outputs are `id` and `alert_rule_ids`. See [EXAMPLES.md](./EXAMPLES.md).

Budget alerts report spend; they do not enforce a hard spending cap. Use
compartment quotas alongside budgets when preventive controls are required.
