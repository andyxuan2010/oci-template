mock_provider "oci" {}

variables {
  compartment_id             = "ocid1.compartment.oc1..exampleuniqueid"
  display_name               = "lb-app-dev"
  subnet_ids                 = ["ocid1.subnet.oc1.iad.exampleuniqueid"]
  is_private                 = true
  network_security_group_ids = ["ocid1.networksecuritygroup.oc1.iad.exampleuniqueid"]
  backend_sets = {
    app = {
      policy = "ROUND_ROBIN"
      health_checker = {
        protocol    = "HTTP"
        port        = 80
        url_path    = "/"
        return_code = 200
      }
    }
  }
  backends = {
    app01 = {
      backend_set_name = "app"
      ip_address       = "10.20.1.10"
      port             = 80
    }
  }
  listeners = {
    http = {
      default_backend_set_name = "app"
      port                     = 80
      protocol                 = "HTTP"
    }
  }
  freeform_tags = {
    environment = "dev"
    managed_by  = "terraform"
  }

}

run "basic_plan" {
  command = plan


}

run "tls_listener" {
  command = plan
  variables {
    listeners = {
      https = { default_backend_set_name = "app", port = 443, protocol = "HTTP", ssl_configuration = { certificate_ids = ["ocid1.certificate.oc1.iad.exampleuniqueid"] } }
    }
  }
  assert {
    condition     = oci_load_balancer_listener.this["https"].ssl_configuration[0].protocols == tolist(["TLSv1.2"])
    error_message = "TLS listeners must use TLSv1.2 by default."
  }
}

run "reject_legacy_tls" {
  command = plan
  variables {
    listeners = {
      https = { default_backend_set_name = "app", port = 443, protocol = "HTTP", ssl_configuration = { certificate_ids = ["ocid1.certificate.oc1.iad.exampleuniqueid"], protocols = ["TLSv1"] } }
    }
  }
  expect_failures = [oci_load_balancer_listener.this["https"]]
}

run "reject_missing_backend_set" {
  command = plan
  variables {
    backends = { bad = { backend_set_name = "missing", ip_address = "10.20.1.10", port = 80 } }
  }
  expect_failures = [oci_load_balancer_backend.this["bad"]]
}
