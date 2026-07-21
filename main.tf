module "compartment" {
  count  = var.create_compartment ? 1 : 0
  source = "./modules/compartment"

  parent_compartment_id = var.tenancy_ocid
  name                  = "cmp-${local.name_suffix}"
  description           = "Compartment for ${var.workload} ${var.environment}"
  freeform_tags         = local.tags
  defined_tags          = var.defined_tags
}

module "vcn" {
  source = "./modules/vcn"

  compartment_id = local.compartment_id
  display_name   = "vcn-${local.name_suffix}"
  cidr_blocks    = var.vcn_cidr_blocks
  dns_label      = replace(substr("${var.workload}${var.environment}", 0, 15), "-", "")
  freeform_tags  = local.tags
  defined_tags   = var.defined_tags
}

module "route_table" {
  source = "./modules/route_table"

  compartment_id          = local.compartment_id
  vcn_id                  = module.vcn.id
  display_name            = "rt-${local.name_suffix}"
  enable_internet_gateway = var.enable_internet_gateway
  enable_nat_gateway      = var.enable_nat_gateway
  route_rules = var.enable_nat_gateway ? [
    {
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      network_entity   = "nat_gateway"
      description      = "Default private egress through NAT gateway"
    }
  ] : []
  freeform_tags = local.tags
  defined_tags  = var.defined_tags
}

module "network_security_group" {
  source = "./modules/network_security_group"

  compartment_id = local.compartment_id
  vcn_id         = module.vcn.id
  display_name   = "nsg-${local.name_suffix}"
  ingress_rules = [
    {
      protocol    = "6"
      source      = var.vcn_cidr_blocks[0]
      source_type = "CIDR_BLOCK"
      description = "Allow SSH from inside the VCN"
      tcp_options = {
        min = 22
        max = 22
      }
    }
  ]
  egress_rules = [
    {
      protocol         = "all"
      destination      = "0.0.0.0/0"
      destination_type = "CIDR_BLOCK"
      description      = "Allow outbound traffic"
    }
  ]
  freeform_tags = local.tags
  defined_tags  = var.defined_tags
}

module "subnet" {
  source = "./modules/subnet"

  compartment_id            = local.compartment_id
  vcn_id                    = module.vcn.id
  default_route_table_id    = module.route_table.id
  default_security_list_ids = [module.vcn.default_security_list_id]
  subnets                   = var.subnets
  freeform_tags             = local.tags
  defined_tags              = var.defined_tags
}

module "compute_instance" {
  count  = var.create_compute_instance ? 1 : 0
  source = "./modules/compute_instance"

  compartment_id      = local.compartment_id
  availability_domain = local.first_ad
  display_name        = "vm-${local.name_suffix}-001"
  shape               = var.compute_shape
  ocpus               = var.compute_ocpus
  memory_in_gbs       = var.compute_memory_in_gbs
  image_ocid          = var.compute_image_ocid
  subnet_id           = module.subnet.ids["app"]
  nsg_ids             = [module.network_security_group.id]
  ssh_public_key      = var.ssh_public_key
  freeform_tags       = local.tags
  defined_tags        = var.defined_tags
}

module "object_storage" {
  count  = var.create_object_storage_bucket ? 1 : 0
  source = "./modules/object_storage"

  compartment_id = local.compartment_id
  namespace      = data.oci_objectstorage_namespace.this.namespace
  name           = "bucket-${local.name_suffix}"
  freeform_tags  = local.tags
  defined_tags   = var.defined_tags
}

module "vault" {
  count  = var.create_vault ? 1 : 0
  source = "./modules/vault"

  compartment_id = local.compartment_id
  display_name   = "vault-${local.name_suffix}"
  freeform_tags  = local.tags
  defined_tags   = var.defined_tags
}
