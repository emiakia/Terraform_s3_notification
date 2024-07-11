variable "s3bse_bucket" {
  description = "The name or ID of the S3 bucket for server-side encryption."
  type        = string
}

variable "s3bse_sse_algorithm" {
  description = "The server-side encryption algorithm (e.g., AES256 for S3-managed keys)."
  type        = string
  default     = "AES256"
}

variable "s3bse_bucket_key_enabled" {
  description = "Whether to enable the S3 Bucket Key."
  type        = bool
  default     = true
}
