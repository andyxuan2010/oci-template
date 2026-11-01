# compute_instance

Creates an OCI compute instance with primary VNIC, optional flexible shape settings, SSH key, and optional cloud-init.

## Usage

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

## Security and Operations

Private VNICs, IMDSv2, and paravirtualized volume encryption in transit are the defaults. Images, shapes, agents, and bootstrap scripts must support these options; set the corresponding booleans explicitly only for a reviewed compatibility exception. `cloud_init` is sensitive but still stored in state. Supply an OpenSSH public key and keep credentials out of bootstrap content.

Authentication is supplied by the calling configuration; this module declares no provider credentials. Taggable resources accept caller-owned `freeform_tags` and `defined_tags`. See [EXAMPLES.md](EXAMPLES.md), the [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).

## Validation

From this module directory:

```powershell
terraform init -backend=false
terraform validate
terraform test
```

[tests/basic.tftest.hcl](tests/basic.tftest.hcl) runs mock-provider plans without OCI credentials or creating resources. Live service availability, permissions, quotas, and network connectivity require a target-tenancy plan.

## Generated Reference

The tables below are generated from Terraform using `scripts/Update-ModuleDocs.ps1`; do not edit them manually.

## Testing

Run the module tests from this directory:

```sh
terraform init -backend=false
terraform test
```

The test files are in [tests](tests).

## Examples

- [Basic](examples/basic): minimal configuration.
- [Complete](examples/complete): every optional input set.

## Providers

| Name | Source | Version |
| --- | --- | --- |
| oci | oracle/oci | >= 8.23.0, < 9.0.0 |

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.7.0 |
| oci | >= 8.23.0, < 9.0.0 |

## Resources

| Name | Type |
|------|------|
| [oci_core_instance.this](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| are\_legacy\_imds\_endpoints\_disabled | Disable legacy unauthenticated instance metadata endpoints; use IMDSv2. | `bool` | `true` | no |
| assign\_public\_ip | Assign a public IP to the primary VNIC. | `bool` | `false` | no |
| availability\_domain | Availability domain name. | `string` | n/a | yes |
| boot\_volume\_size\_in\_gbs | Optional boot volume size. | `number` | `null` | no |
| cloud\_init | Optional cloud-init content. | `string` | `null` | no |
| compartment\_id | Compartment OCID. | `string` | n/a | yes |
| defined\_tags | OCI defined tags. | `map(string)` | `{}` | no |
| display\_name | Instance display name. | `string` | n/a | yes |
| freeform\_tags | OCI freeform tags. | `map(string)` | `{}` | no |
| image\_ocid | Source image OCID. | `string` | n/a | yes |
| is\_pv\_encryption\_in\_transit\_enabled | Encrypt paravirtualized boot/data volume traffic; requires a compatible image and shape. | `bool` | `true` | no |
| memory\_in\_gbs | Memory in GBs for flexible shapes. | `number` | `null` | no |
| nsg\_ids | NSG OCIDs attached to the primary VNIC. | `list(string)` | `[]` | no |
| ocpus | OCPUs for flexible shapes. | `number` | `null` | no |
| shape | Compute shape. | `string` | n/a | yes |
| ssh\_public\_key | SSH public key injected into the default opc user. | `string` | n/a | yes |
| subnet\_id | Subnet OCID. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Instance OCID. |
| private\_ip | Primary private IP. |
| public\_ip | Primary public IP when assigned. |
<!-- END_TF_DOCS -->
