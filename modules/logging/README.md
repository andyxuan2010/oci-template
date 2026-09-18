# OCI Logging Module

Creates an OCI log group and zero or more service/custom logs. For service logs,
provide a `configuration` containing the OCI service, category, resource OCID,
and source type. Retention defaults to 30 days.

Outputs are `log_group_id` and `log_ids`. See [EXAMPLES.md](./EXAMPLES.md).
