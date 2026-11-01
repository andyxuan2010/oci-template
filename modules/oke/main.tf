resource "oci_containerengine_cluster" "this" {
  compartment_id     = var.compartment_id
  name               = var.name
  vcn_id             = var.vcn_id
  kubernetes_version = var.kubernetes_version
  type               = "BASIC_CLUSTER"
  kms_key_id         = var.kms_key_id
  endpoint_config {
    subnet_id            = var.endpoint_subnet_id
    is_public_ip_enabled = false
    nsg_ids              = var.endpoint_nsg_ids
  }
  cluster_pod_network_options {
    cni_type = "FLANNEL_OVERLAY"
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}

resource "oci_containerengine_node_pool" "this" {
  for_each           = var.node_pools
  compartment_id     = var.compartment_id
  cluster_id         = oci_containerengine_cluster.this.id
  name               = each.key
  kubernetes_version = var.kubernetes_version
  node_shape         = each.value.node_shape
  ssh_public_key     = each.value.ssh_public_key
  node_shape_config {
    ocpus         = each.value.ocpus
    memory_in_gbs = each.value.memory_in_gbs
  }
  node_source_details {
    image_id    = each.value.image_id
    source_type = "IMAGE"
  }
  node_config_details {
    size    = each.value.size
    nsg_ids = each.value.nsg_ids
    dynamic "placement_configs" {
      for_each = each.value.placements
      content {
        availability_domain = placement_configs.value.availability_domain
        subnet_id           = placement_configs.value.subnet_id
      }
    }
  }
  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}
