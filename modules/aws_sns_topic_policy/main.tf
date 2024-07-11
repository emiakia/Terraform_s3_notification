resource "aws_sns_topic_policy" "this" {
  arn    = var.snstp_arn

  policy = var.snstp_policy
}
