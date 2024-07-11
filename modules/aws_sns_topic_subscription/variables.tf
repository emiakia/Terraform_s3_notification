variable "snss_topic_arn" {
  description = "The ARN of the SNS topic"
  type        = string
}

variable "snss_protocol" {
  description = "The protocol for the subscription (e.g., 'email', 'http', 'lambda')"
  type        = string
}

variable "snss_endpoint" {
  description = "The endpoint to receive notifications (e.g., an email address or an HTTP URL)"
  type        = string
}
