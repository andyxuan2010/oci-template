# Notification Topic Examples

```hcl
module "notification_topic" {
  source = "git::https://github.com/andyxuan2010/oci-template.git//modules/notification_topic"

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
