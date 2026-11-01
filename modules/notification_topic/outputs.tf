output "id" {
  description = "Notification topic OCID."
  value       = oci_ons_notification_topic.this.id
}

output "topic_id" {
  description = "Notification topic OCID for alarm destinations."
  value       = oci_ons_notification_topic.this.id
}

output "subscription_ids" {
  description = "Subscription OCIDs keyed by subscription name."
  value       = { for name, subscription in oci_ons_subscription.this : name => subscription.id }
}
