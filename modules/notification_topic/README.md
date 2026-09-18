# OCI Notification Topic Module

Creates an OCI Notifications topic and optional subscriptions. Supported
protocols depend on OCI and include `EMAIL`, `HTTPS`, `PAGERDUTY`, `SLACK`, and
`ORACLE_FUNCTIONS`.

Email subscriptions remain pending until the recipient confirms them. Outputs
are `id`, `topic_id`, and `subscription_ids`. See [EXAMPLES.md](./EXAMPLES.md).
