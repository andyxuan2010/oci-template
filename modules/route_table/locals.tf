locals {
  network_entity_ids = {
    internet_gateway = try(oci_core_internet_gateway.this[0].id, null)
    nat_gateway      = try(oci_core_nat_gateway.this[0].id, null)
  }
}
