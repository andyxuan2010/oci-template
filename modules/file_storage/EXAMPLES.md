# file_storage Examples

## Basic Example

```hcl
module "file_storage" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/file_storage"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  file_system_display_name = "fss-app-dev"
  mount_target_display_name = "mt-app-dev"
  subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  hostname_label = "fssappdev"
  nsg_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  export_path = "/appdev"
  export_options = [
    {
      source = "10.20.0.0/16"
      access = "READ_WRITE"
    }
  ]
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
