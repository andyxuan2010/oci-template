# OCI Compute Instance Module

Creates an OCI compute instance with primary VNIC, optional flexible shape settings, SSH key, and optional cloud-init.

## Usage

Use this for Linux jump hosts, app hosts, or platform utility servers once image, SSH, and subnet choices are explicit.

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

## Inputs

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `compartment_id` | `string` | Yes | Compartment OCID. |
| `availability_domain` | `string` | Yes | Availability domain name. |
| `display_name` | `string` | Yes | Instance display name. |
| `shape` | `string` | Yes | Compute shape. |
| `ocpus` | `number` | No | OCPUs for flexible shapes. |
| `memory_in_gbs` | `number` | No | Memory in GBs for flexible shapes. |
| `image_ocid` | `string` | Yes | Source image OCID. |
| `subnet_id` | `string` | Yes | Subnet OCID. |
| `nsg_ids` | `list(string)` | No | NSG OCIDs attached to the primary VNIC. |
| `assign_public_ip` | `bool` | No | Assign a public IP to the primary VNIC. |
| `ssh_public_key` | `string` | Yes | SSH public key injected into the default opc user. |
| `boot_volume_size_in_gbs` | `number` | No | Optional boot volume size. |
| `cloud_init` | `string` | No | Optional cloud-init content. |
| `freeform_tags` | `map(string)` | No | OCI freeform tags. |
| `defined_tags` | `map(string)` | No | OCI defined tags. |

## Outputs

| Name | Description |
| --- | --- |
| `id` | Instance OCID. |
| `private_ip` | Primary private IP. |
| `public_ip` | Primary public IP when assigned. |

## Examples

See [EXAMPLES.md](./EXAMPLES.md) for a complete example.

## Terraform Tests

This module includes a mock-provider plan test at [tests/basic.tftest.hcl](./tests/basic.tftest.hcl). Run it from the module directory:

```powershell
terraform init -backend=false
terraform test
```

The repository-level validation helper also validates module syntax:

```powershell
.\test.ps1 modules\compute_instance\main.tf
```
