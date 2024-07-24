
#S3 Bucket Variable
s3b_bucket_name = "emrankiaterraform"

#S3 Bucket versioning variables
s3bv_status = "Enabled"


#aws_s3_bucket_server_side_encryption_configuration variables
bucket_name              = "emrankiaterraform"
s3bse_sse_algorithm      = "AES256" # Optional, using default
s3bse_bucket_key_enabled = true     # Optional, using default


#aws_s3_bucket_public_access_block variables
s3bpab_block_public_acls   = false
s3bpab_block_public_policy = false

#aws_sqs_queue variables
sqsq_name = "sqs_notification"

#aws_s3_bucket_notification variables
s3bkn_events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
s3bkn_topic_arn = "" # Optional, if you use SNS topic uncomment and set
