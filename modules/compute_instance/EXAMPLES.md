# compute_instance Examples

## Basic Example

```hcl
module "compute_instance" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/compute_instance"

  compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name = "vm-app-dev-001"
  shape = "VM.Standard.E5.Flex"
  ocpus = 1
  memory_in_gbs = 8
  image_ocid = "ocid1.image.oc1.iad.exampleuniqueid"
  subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  nsg_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDexample user@example"
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
