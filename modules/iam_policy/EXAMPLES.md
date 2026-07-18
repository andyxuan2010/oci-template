# iam_policy Examples

## Basic Example

```hcl
module "iam_policy" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/iam_policy"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  name = "policy-app-dev"
  description = "Allow app operators to inspect instances"
  statements = ["Allow group app-operators to inspect instances in compartment cmp-app-dev"]
  freeform_tags = {
    environment = "dev"
    managed_by = "terraform"
  }
}
```

## Notes

- Replace example OCIDs and names with values from the target OCI tenancy.
- Keep `freeform_tags` and `defined_tags` consistent with the root tagging standard.
- Run `terraform plan` before applying in a live tenancy.
