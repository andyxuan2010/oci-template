# dns_record Examples

## Basic Composition

```hcl
module "dns_record" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/dns_record"

  zone_id = "ocid1.dns-zone.oc1..exampleuniqueid"
  domain  = "app.internal.example.com"
  rtype   = "A"
  records = ["10.20.1.10", "10.20.1.11"]
}
```

## Deployment Notes

Connect `zone_id` to the existing `dns_zone` module output. The module looks up the zone using the requested scope before creating records, and requires permission to read that zone. The RRSet scope is inferred from the resolved zone ID; it does not use the deprecated RRSet `scope` argument. One module call owns every value for a zone/domain/type tuple; import an existing RRSet before managing it. For a public zone set `scope = "GLOBAL"`. Private zone resolver/view associations remain with the DNS/network owner. OCI RRSets do not support tags.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
