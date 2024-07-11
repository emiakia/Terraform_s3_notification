output "bucket_id" {
  value = module.s3_bucket.bucket_id
}

output "bucket_arn" {
  value = module.s3_bucket.bucket_arn
}

output "bucket_versioning_status" {
  value = module.s3_bucket_versioning.versioning_status
}

output "encryption_algorithm" {
  value = module.s3_bucket_encryption.encryption_algorithm
}

output "bucket_key_enabled" {
  value = module.s3_bucket_encryption.bucket_key_enabled
}

output "block_public_acls" {
  value = module.s3_bucket_public_access_block.block_public_acls
}

output "block_public_policy" {
  value = module.s3_bucket_public_access_block.block_public_policy
}

output "sns_topic_arn" {
  value = module.sns_topic.sns_topic_arn
}

output "sns_subscription_arn" {
  value = module.sns_topic_subscription.sns_subscription_arn
}

# output "s3_notification_id" {
#   value = module.s3_bucket_notification.notification_id
# }
