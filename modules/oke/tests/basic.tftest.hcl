mock_provider "oci" {}

variables {
  compartment_id     = "ocid1.compartment.oc1..exampleuniqueid"
  name               = "oke-app-dev"
  vcn_id             = "ocid1.vcn.oc1.iad.exampleuniqueid"
  kubernetes_version = "v1.34.1"
  endpoint_subnet_id = "ocid1.subnet.oc1.iad.exampleuniqueid"
  node_pools = {
    app = {
      image_id = "ocid1.image.oc1.iad.exampleuniqueid"
      placements = {
        ad1 = { availability_domain = "example:US-ASHBURN-AD-1", subnet_id = "ocid1.subnet.oc1.iad.workerexample" }
      }
    }
  }
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = !oci_containerengine_cluster.this.endpoint_config[0].is_public_ip_enabled
    error_message = "Kubernetes API must have no public IP."
  }
  assert {
    condition     = oci_containerengine_node_pool.this["app"].node_config_details[0].size == 1
    error_message = "Worker count must use the configured default."
  }
}

run "cluster_only" {
  command = plan
  variables {
    node_pools = {}
  }
  assert {
    condition     = length(oci_containerengine_node_pool.this) == 0
    error_message = "Worker pools must be optional."
  }
}

run "reject_empty_placements" {
  command = plan
  variables {
    node_pools = { app = { image_id = "ocid1.image.oc1.iad.exampleuniqueid", placements = {} } }
  }
  expect_failures = [var.node_pools]
}
