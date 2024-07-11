output "sns_subscription_arn" {
  description = "The ARN of the SNS subscription"
  value       = aws_sns_topic_subscription.this.arn
}

output "sns_subscription_id" {
  description = "The ID of the SNS subscription"
  value       = aws_sns_topic_subscription.this.id
}
