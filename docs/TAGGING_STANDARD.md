# OCI Tagging Standard

Use `freeform_tags` for common ownership and environment metadata, and `defined_tags` for organization-controlled namespaces. Do not put credentials, tokens, personal identifiers, or confidential data in tags.

Recommended freeform keys are `workload`, `environment`, `managed_by`, `owner`, and `cost_center`. The root enforces `workload`, `environment`, and `managed_by = "terraform"` after merging caller tags. Leaf modules pass caller values through and do not add hidden tags.

Defined-tag keys use `namespace.key` syntax and require pre-existing tag definitions and appropriate IAM permissions. Compose `tag_namespace` before resources that consume its definitions, and use `tag_default` for required or default compartment values.

Only taggable OCI resources expose these inputs. DNS RRSets, tag defaults, volume-backup assignments, and some child resources have no independent tag support. Parent resource tags do not prove every child has inherited tags. Review policies, budgets, cost-tracking definitions, and tag retirement with the resource owners.
