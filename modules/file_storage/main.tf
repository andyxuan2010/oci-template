resource "oci_file_storage_file_system" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  display_name        = var.file_system_display_name
  kms_key_id          = var.kms_key_id
  freeform_tags       = var.freeform_tags
  defined_tags        = var.defined_tags
}

resource "oci_file_storage_mount_target" "this" {
  availability_domain = var.availability_domain
  compartment_id      = var.compartment_id
  subnet_id           = var.subnet_id
  display_name        = var.mount_target_display_name
  hostname_label      = var.hostname_label
  nsg_ids             = var.nsg_ids
  freeform_tags       = var.freeform_tags
  defined_tags        = var.defined_tags
}

resource "oci_file_storage_export" "this" {
  export_set_id  = oci_file_storage_mount_target.this.export_set_id
  file_system_id = oci_file_storage_file_system.this.id
  path           = var.export_path

  dynamic "export_options" {
    for_each = var.export_options
    content {
      source                         = export_options.value.source
      access                         = export_options.value.access
      identity_squash                = export_options.value.identity_squash
      anonymous_gid                  = export_options.value.anonymous_gid
      anonymous_uid                  = export_options.value.anonymous_uid
      allowed_auth                   = export_options.value.allowed_auth
      is_anonymous_access_allowed    = export_options.value.is_anonymous_access_allowed
      require_privileged_source_port = export_options.value.require_privileged_source_port
    }
  }
}
