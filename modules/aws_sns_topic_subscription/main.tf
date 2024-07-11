resource "aws_sns_topic_subscription" "this" {
  topic_arn = var.snss_topic_arn
  protocol  = var.snss_protocol
  endpoint  = var.snss_endpoint
}
