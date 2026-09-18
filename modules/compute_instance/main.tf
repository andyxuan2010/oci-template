resource "oci_core_instance" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  shape               = var.shape
  freeform_tags       = var.freeform_tags
  defined_tags        = var.defined_tags

  dynamic "shape_config" {
    for_each = var.ocpus == null && var.memory_in_gbs == null ? [] : [1]
    content {
      ocpus         = var.ocpus
      memory_in_gbs = var.memory_in_gbs
    }
  }

  create_vnic_details {
    subnet_id        = var.subnet_id
    assign_public_ip = var.assign_public_ip
    nsg_ids          = var.nsg_ids
    display_name     = "${var.display_name}-vnic"
  }

  source_details {
    source_type             = "image"
    source_id               = var.image_ocid
    boot_volume_size_in_gbs = var.boot_volume_size_in_gbs
  }

  metadata = merge(
    {
      ssh_authorized_keys = var.ssh_public_key
    },
    var.cloud_init == null ? {} : {
      user_data = base64encode(var.cloud_init)
    }
  )
}
