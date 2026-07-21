# OCI Bastion Module

Creates an OCI Bastion endpoint for controlled access to private targets. The
standard bastion defaults to a three-hour maximum session TTL; use the smallest
practical client CIDR allow list rather than `0.0.0.0/0`.

This module creates the bastion, not individual ephemeral bastion sessions.
Outputs are `id`, `private_endpoint_ip_address`, and `state`. See
[EXAMPLES.md](./EXAMPLES.md).
