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
      access                         = try(export_options.value.access, "READ_WRITE")
      identity_squash                = try(export_options.value.identity_squash, "NONE")
      anonymous_gid                  = try(export_options.value.anonymous_gid, null)
      anonymous_uid                  = try(export_options.value.anonymous_uid, null)
      allowed_auth                   = try(export_options.value.allowed_auth, null)
      is_anonymous_access_allowed    = try(export_options.value.is_anonymous_access_allowed, null)
      require_privileged_source_port = try(export_options.value.require_privileged_source_port, null)
    }
  }
}
