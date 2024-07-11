resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = var.s3bse_bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.s3bse_sse_algorithm
    }
    bucket_key_enabled = var.s3bse_bucket_key_enabled
  }
}
