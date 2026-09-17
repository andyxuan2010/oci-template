resource "oci_core_volume" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.display_name
  size_in_gbs         = var.size_in_gbs
  vpus_per_gb         = var.vpus_per_gb
  kms_key_id          = var.kms_key_id
  freeform_tags       = var.freeform_tags
  defined_tags        = var.defined_tags
}

resource "oci_core_volume_backup_policy_assignment" "this" {
  count = var.backup_policy_id == null ? 0 : 1

  asset_id  = oci_core_volume.this.id
  policy_id = var.backup_policy_id
}

resource "oci_core_volume_attachment" "this" {
  count = var.attach_to_instance_id == null ? 0 : 1

  attachment_type = var.attachment_type
  instance_id     = var.attach_to_instance_id
  volume_id       = oci_core_volume.this.id
  display_name    = "${var.display_name}-attachment"
  is_read_only    = var.is_read_only
  is_shareable    = var.is_shareable
}
