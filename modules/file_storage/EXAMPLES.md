# file_storage Examples

## Basic Composition

```hcl
module "file_storage" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/file_storage"

  compartment_id            = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain       = "Uocm:US-ASHBURN-AD-1"
  file_system_display_name  = "fss-app-dev"
  mount_target_display_name = "mt-app-dev"
  subnet_id                 = "ocid1.subnet.oc1.iad.exampleuniqueid"
  hostname_label            = "fssappdev"
  nsg_ids                   = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  export_path               = "/appdev"
  export_options = [
    {
      source = "10.20.0.0/16"
      access = "READ_WRITE"
    }
  ]
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

At least one explicit client CIDR narrower than /0 is required; omitted/empty export rules are rejected. Defaults squash root, require privileged client ports, and disable anonymous access. Existing clients may need mount or identity changes. Mount targets are private; restrict NSGs and select NFS authentication/encryption appropriate to the workload. Customer-managed at-rest keys are optional.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
