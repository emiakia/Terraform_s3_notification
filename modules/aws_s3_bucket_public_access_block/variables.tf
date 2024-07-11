variable "s3bpab_bucket" {
  description = "The name or ID of the S3 bucket."
  type        = string
}

variable "s3bpab_block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = false
}

variable "s3bpab_block_public_policy" {
  description = "Whether Amazon S3 should block public policies for this bucket."
  type        = bool
  default     = false
}
