mock_provider "oci" {}

run "basic_plan" {
  command = plan

  variables {
    compartment_id        = "ocid1.compartment.oc1..exampleuniqueid"
    metric_compartment_id = "ocid1.compartment.oc1..exampleuniqueid"
    display_name          = "alarm-compute-cpu-dev"
    namespace             = "oci_computeagent"
    query                 = "CpuUtilization[5m].mean() > 80"
    severity              = "WARNING"
    destinations          = ["ocid1.onstopic.oc1.iad.exampleuniqueid"]
  }
}
