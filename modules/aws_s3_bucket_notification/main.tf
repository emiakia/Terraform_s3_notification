resource "aws_s3_bucket_notification" "this" {
  bucket = var.s3bkn_bucket_id

  # queue {
  #   queue_arn = var.s3bkn_queue_arn
  #   events    = var.s3bkn_events
  # }

  # Optional SNS topic configuration
  topic {
    topic_arn = var.s3bkn_topic_arn
    events    = var.s3bkn_events
  }

  # depends_on = var.s3bkn_depends_on
}
