
output "encryption_algorithm" {
  description = "The server-side encryption algorithm applied to the bucket."
  value       = [for r in aws_s3_bucket_server_side_encryption_configuration.this.rule : r.apply_server_side_encryption_by_default[0].sse_algorithm][0]
}

output "bucket_key_enabled" {
  description = "Whether the S3 Bucket Key is enabled."
  value       = [for r in aws_s3_bucket_server_side_encryption_configuration.this.rule : r.bucket_key_enabled][0]
}
