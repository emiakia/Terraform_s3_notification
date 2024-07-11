variable "s3bkn_bucket_id" {
  description = "The ID of the S3 bucket to configure notifications for."
  type        = string
}

variable "s3bkn_queue_arn" {
  description = "The ARN of the SQS queue to receive notifications."
  type        = string
}

variable "s3bkn_events" {
  description = "The events to notify the SQS queue about."
  type        = list(string)
  default     = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
}

variable "s3bkn_topic_arn" {
  description = "The ARN of the SNS topic to receive notifications (optional)."
  type        = string
  default     = ""
}

variable "s3bkn_depends_on" {
  description = "Resources that the S3 bucket notification depends on."
  type        = list(any)
  default     = []
}
