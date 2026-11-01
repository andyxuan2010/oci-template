output "id" {
  description = "DRG OCID."
  value       = oci_core_drg.this.id
}

output "display_name" {
  description = "DRG display name."
  value       = oci_core_drg.this.display_name
}

output "vcn_attachment_ids" {
  description = "DRG VCN attachment OCIDs keyed by logical attachment name."
  value       = { for key, attachment in oci_core_drg_attachment.vcn : key => attachment.id }
}
