# compute_instance Examples

## Basic Composition

```hcl
module "compute_instance" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/compute_instance"

  compartment_id      = "ocid1.compartment.oc1..exampleuniqueid"
  availability_domain = "Uocm:US-ASHBURN-AD-1"
  display_name        = "vm-app-dev-001"
  shape               = "VM.Standard.E5.Flex"
  ocpus               = 1
  memory_in_gbs       = 8
  image_ocid          = "ocid1.image.oc1.iad.exampleuniqueid"
  subnet_id           = "ocid1.subnet.oc1.iad.exampleuniqueid"
  nsg_ids             = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  ssh_public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDexample user@example"
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}
```

## Deployment Notes

Private VNICs, IMDSv2, and paravirtualized volume encryption in transit are the defaults. Images, shapes, agents, and bootstrap scripts must support these options; set the corresponding booleans explicitly only for a reviewed compatibility exception. `cloud_init` is sensitive but still stored in state. Supply an OpenSSH public key and keep credentials out of bootstrap content.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
