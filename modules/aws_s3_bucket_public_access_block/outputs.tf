output "block_public_acls" {
  description = "Whether public ACLs are blocked."
  value       = aws_s3_bucket_public_access_block.this.block_public_acls
}

output "block_public_policy" {
  description = "Whether public policies are blocked."
  value       = aws_s3_bucket_public_access_block.this.block_public_policy
}
