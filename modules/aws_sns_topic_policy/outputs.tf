output "sns_topic_policy_id" {
  description = "The ID of the SNS topic policy"
  value       = aws_sns_topic_policy.this.id
}
