terraform {
  required_version = ">= 1.7.0"

  required_providers {
    oci = {
      source  = "oracle/oci"
      version = ">= 8.23.0, < 9.0.0"
    }
  }
}

provider "oci" {}

module "example" {
  source                                        = "../.."
  compartment_id                                = "ocid1.compartment.oc1..exampleuniqueid"
  metric_compartment_id                         = "ocid1.compartment.oc1..exampleuniqueid"
  display_name                                  = "example-display-name"
  namespace                                     = "example-namespace"
  query                                         = "example-query"
  severity                                      = "WARNING"
  destinations                                  = ["ocid1.destinations.oc1..exampleuniqueid"]
  is_enabled                                    = true
  body                                          = null
  alarm_summary                                 = null
  pending_duration                              = "PT5M"
  repeat_notification_duration                  = null
  resolution                                    = null
  resource_group                                = null
  metric_compartment_id_in_subtree              = false
  message_format                                = null
  notification_title                            = null
  is_notifications_per_metric_dimension_enabled = false
  suppression                                   = null
  freeform_tags                                 = {}
  defined_tags                                  = {}
}
