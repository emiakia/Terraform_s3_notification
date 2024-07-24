provider "aws" {
  region = "eu-central-1" # Change to your preferred region
}
module "s3_bucket" {
  source          = "./modules/aws_s3_bucket"
  s3b_bucket_name = var.s3b_bucket_name
}

module "s3_bucket_versioning" {
  source      = "./modules/aws_s3_bucket_versioning"
  s3bv_bucket = module.s3_bucket.bucket_id
  s3bv_status = "Disabled" # You can change this value to "Disabled" if desired
}

module "s3_bucket_encryption" {
  source                   = "./modules/aws_s3_bucket_encryption"
  s3bse_bucket             = module.s3_bucket.bucket_id
  s3bse_sse_algorithm      = var.s3bse_sse_algorithm      # Optional, uses default value if not set
  s3bse_bucket_key_enabled = var.s3bse_bucket_key_enabled # Optional, uses default value if not set
}

module "s3_bucket_public_access_block" {
  source                     = "./modules/aws_s3_bucket_public_access_block"
  s3bpab_bucket              = module.s3_bucket.bucket_id
  s3bpab_block_public_acls   = var.s3bpab_block_public_acls   # Optional, uses default value if not set
  s3bpab_block_public_policy = var.s3bpab_block_public_policy # Optional, uses default value if not set
}

###########################################################################################
###########################################################################################
###########################################################################################

# Create an SNS Topic for notifications
module "sns_topic" {
  source   = "./modules/aws_sns_topic"
  sns_name = "S3NotificationTopic" # You can adjust the topic name here
}

# resource "aws_sns_topic" "sns_notification" {
#   name = "S3NotificationTopic"
# }

# Create SNS Topic Policy to allow S3 to publish messages to the SNS topic
module "sns_topic_policy" {
  source       = "./modules/aws_sns_topic_policy"
  snstp_arn    = module.sns_topic.sns_topic_arn
  snstp_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SNSNotificationPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sns:Publish",
      "Resource": "${module.sns_topic.sns_topic_arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${module.s3_bucket.bucket_arn}"
        }
      }
    }
  ]
}
POLICY
}
# resource "aws_sns_topic_policy" "sns_notification_policy" {
#   arn = module.sns_topic.sns_topic_arn

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "SNSNotificationPolicy",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "sns:Publish",
#       "Resource": "${module.sns_topic.sns_topic_arn}",
#       "Condition": {
#         "ArnEquals": {
#           "aws:SourceArn": "${module.s3_bucket.bucket_arn}"
#         }
#       }
#     }
#   ]
# }
# POLICY
# }

# Add an email subscription to the SNS topic
module "sns_topic_subscription" {
  source         = "./modules/aws_sns_topic_subscription"
  snss_topic_arn = module.sns_topic.sns_topic_arn
  snss_protocol  = "email"
  snss_endpoint  = "emran.kia@gmail.com"
}

# resource "aws_sns_topic_subscription" "email_subscription" {
#   topic_arn = module.sns_topic.sns_topic_arn
#   protocol  = "email"
#   endpoint  = "emran.kia@gmail.com"
# }
###########################################################################################
###########################################################################################
###########################################################################################

# # Create an EventBridge rule for S3 events
# resource "aws_cloudwatch_event_rule" "s3_event_rule" {
#   name        = "S3EventRule"
#   event_pattern = jsonencode({
#     source = ["aws.s3"]
#     detail_type = ["AWS API Call via CloudTrail"]
#     detail = {
#       eventSource = ["s3.amazonaws.com"]
#       eventName = ["PutObject"]
#     }
#   })
# }

# # Target the SNS topic and SQS queue
# resource "aws_cloudwatch_event_target" "s3_event_target_sns" {
#   rule = aws_cloudwatch_event_rule.s3_event_rule.name
#   arn  = aws_sns_topic.sns_notification.arn
# }

# resource "aws_cloudwatch_event_target" "s3_event_target_sqs" {
#   rule = aws_cloudwatch_event_rule.s3_event_rule.name
#   arn  = aws_sqs_queue.sqs_notification.arn
# }

# Create an S3 bucket notification to trigger both SNS and SQS on object creation events
module "s3_bucket_notification" {
  source          = "./modules/aws_s3_bucket_notification"
  s3bkn_bucket_id = module.s3_bucket.bucket_id
  s3bkn_queue_arn = "" #module.sqs_queue.sqs_queue_arn
  s3bkn_events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  s3bkn_topic_arn = module.sns_topic.sns_topic_arn # Optional, if you use SNS topic uncomment and set
  # s3bkn_depends_on = [module.sqs_queue_policy]  # Optional, include other dependencies as needed
}


# resource "aws_s3_bucket_notification" "emrankia_notification" {
#   bucket = module.s3_bucket.bucket_id

# #   queue {
# #     queue_arn = aws_sqs_queue.sqs_notification.arn
# #     events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*]
# #   }

#   topic {
#     topic_arn = module.sns_topic.sns_topic_arn
#     events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
#   }

#   depends_on = [
#     # aws_sqs_queue_policy.sqs_notification_policy,
#     module.sns_topic_policy
#   ]
# }

