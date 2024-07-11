variable "s3b_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

#################################################################
variable "s3bv_status" {
  description = "The versioning status of the S3 bucket (e.g., Enabled, Disabled)."
  type        = string
  default     = "Disabled"
}

#################################################################
variable "bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
}

variable "s3bse_sse_algorithm" {
  description = "The server-side encryption algorithm (e.g., AES256)."
  type        = string
  default     = "AES256"
}

variable "s3bse_bucket_key_enabled" {
  description = "Whether to enable the S3 Bucket Key."
  type        = bool
  default     = true
}

##########################################################################
#aws_s3_bucket_public_access_block variables
variable "s3bpab_block_public_acls" {
  description = "Whether to block public ACLs for the S3 bucket."
  type        = bool
  default     = false
}

variable "s3bpab_block_public_policy" {
  description = "Whether to block public policies for the S3 bucket."
  type        = bool
  default     = false
}
#########################################################################
#aws_sqs_queue variables
variable "sqsq_name" {
  description = "The name of the SQS queue."
  type        = string
}


#########################################################################
#aws_s3_bucket_notification variables
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
