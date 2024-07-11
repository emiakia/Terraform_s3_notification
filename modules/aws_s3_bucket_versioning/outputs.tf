output "versioning_status" {
  description = "The status of the S3 bucket versioning."
  value       = aws_s3_bucket_versioning.this.versioning_configuration[0].status
}
