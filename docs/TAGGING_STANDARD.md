# OCI Tagging Standard

This repository uses a root-owned tagging model for OCI freeform and defined tags.

## Source of Truth

The root composition owns common tag normalization and passes tags to child modules.

The root currently adds these freeform tags:

```hcl
{
  workload    = var.workload
  environment = var.environment
  managed_by  = "terraform"
}
```

These values are merged with `var.freeform_tags`, and the merged map is passed to modules as `freeform_tags`.

## Standard Inputs

Modules should expose both OCI tag types:

```hcl
variable "freeform_tags" {
  description = "OCI freeform tags."
  type        = map(string)
  default     = {}
}

variable "defined_tags" {
  description = "OCI defined tags."
  type        = map(string)
  default     = {}
}
```

Resources that support tags should set:

```hcl
freeform_tags = var.freeform_tags
defined_tags  = var.defined_tags
```

## Merge Order

Root-level tag merge order is:

```hcl
tags = merge(
  var.freeform_tags,
  {
    workload    = var.workload
    environment = var.environment
    managed_by  = "terraform"
  }
)
```

The root-managed keys win so every resource has consistent workload, environment, and ownership metadata.

## Defined Tags

Use `defined_tags` when the tenancy has tag namespaces and governance policies that require typed, controlled tag keys. Defined tag keys must already exist in the tenancy before Terraform can apply them to resources.

Example:

```hcl
defined_tags = {
  "Operations.CostCenter" = "ccoe"
  "Operations.Owner"      = "cloud-platform"
}
```

## Validation Checklist

When adding or changing a module:

- Expose `freeform_tags` and `defined_tags`.
- Apply both tag maps to all OCI resources that support them.
- Do not redefine `workload`, `environment`, or `managed_by` inside child modules.
- Keep tag examples free of secrets and personal data.
