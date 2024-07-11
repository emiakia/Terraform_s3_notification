resource "aws_s3_bucket_versioning" "this" {
  bucket = var.s3bv_bucket

  versioning_configuration {
    status = var.s3bv_status
  }
}
