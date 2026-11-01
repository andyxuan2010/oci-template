locals {
  name_suffix = lower("${var.workload}-${var.environment}")
  tags = merge(
    var.freeform_tags,
    {
      workload    = var.workload
      environment = var.environment
      managed_by  = "terraform"
    }
  )

  compartment_id = var.create_compartment ? module.compartment[0].id : var.compartment_ocid
  first_ad       = data.oci_identity_availability_domains.this.availability_domains[0].name
}
