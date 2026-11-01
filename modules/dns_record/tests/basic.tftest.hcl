mock_provider "oci" {}

variables {
  zone_id = "ocid1.dns-zone.oc1..exampleuniqueid"
  domain  = "app.internal.example.com"
  rtype   = "A"
  records = ["10.20.1.10", "10.20.1.11"]
}

run "secure_defaults" {
  command = plan
  assert {
    condition     = data.oci_dns_zone.this.scope == "PRIVATE"
    error_message = "Zone lookup must select private scope by default."
  }
  assert {
    condition     = oci_dns_rrset.this.zone_name_or_id == data.oci_dns_zone.this.id
    error_message = "Records must use the zone returned by the scoped lookup."
  }
}

run "public_record" {
  command = plan
  variables {
    scope = "GLOBAL"
    rtype = "a"
  }
  assert {
    condition     = data.oci_dns_zone.this.scope == "GLOBAL" && oci_dns_rrset.this.rtype == "A"
    error_message = "Public scope must be explicit and record types normalized."
  }
}

run "reject_empty_records" {
  command = plan
  variables {
    records = []
  }
  expect_failures = [var.records]
}
