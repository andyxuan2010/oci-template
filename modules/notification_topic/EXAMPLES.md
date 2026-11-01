# notification_topic Examples

## Basic Composition

```hcl
module "notification_topic" {
  source = "git::https://github.com/CCOE-Azure/oci-template.git//modules/notification_topic"

  compartment_id = var.compartment_id
  name           = "topic-platform-dev"
  description    = "Landing-zone operational notifications"

  subscriptions = {
    platform_email = {
      protocol = "EMAIL"
      endpoint = "platform@example.com"
    }
  }
}
```

## Deployment Notes

Grant publish/subscribe IAM separately. Email subscriptions require recipient confirmation. Avoid putting credentials or confidential payloads in notification endpoints or message bodies.

Replace illustrative OCIDs, addresses, images, and names with target-environment values. Supply referenced caller variables through protected inputs. Pin remote module sources to a reviewed release or commit using `?ref=<ref>` before production deployment. Run a live plan and review IAM and network reachability before applying.

See the [module reference](README.md), [security standard](../../SECURITY.md), and [migration notes](../../docs/MIGRATION.md).
