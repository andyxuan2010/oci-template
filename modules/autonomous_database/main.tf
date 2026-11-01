resource "oci_database_autonomous_database" "this" {
  compartment_id              = var.compartment_id
  display_name                = var.display_name
  db_name                     = var.db_name
  admin_password              = var.admin_password
  db_workload                 = "OLTP"
  compute_model               = "ECPU"
  compute_count               = var.compute_count
  data_storage_size_in_tbs    = var.data_storage_size_in_tbs
  license_model               = var.license_model
  is_auto_scaling_enabled     = var.is_auto_scaling_enabled
  is_dedicated                = false
  is_mtls_connection_required = true
  subnet_id                   = var.subnet_id
  nsg_ids                     = var.nsg_ids
  freeform_tags               = var.freeform_tags
  defined_tags                = var.defined_tags
}
