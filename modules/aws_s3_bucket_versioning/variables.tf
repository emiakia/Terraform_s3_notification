#S3 Bucket variable
variable "s3bv_bucket" {
  description = "The name or ID of the S3 bucket for versioning."
  type        = string
}
#S3 Bucket versioning variable
variable "s3bv_status" {
  description = "The versioning status of the S3 bucket (e.g., Enabled, Disabled)."
  type        = string
  default     = "Disabled"
}


