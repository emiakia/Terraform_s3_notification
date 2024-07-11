resource "aws_s3_bucket_public_access_block" "this" {
  bucket = var.s3bpab_bucket

  block_public_acls   = var.s3bpab_block_public_acls
  block_public_policy = var.s3bpab_block_public_policy
}
