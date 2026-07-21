# OCI Monitoring Alarm Module

Creates one OCI Monitoring alarm with notification destinations and an optional
suppression window. The caller supplies the metric namespace and Monitoring
Query Language expression so the module works across OCI services.

Outputs are `id` and `state`. See [EXAMPLES.md](./EXAMPLES.md).
