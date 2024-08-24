provider "aws" {
  region = "eu-central-1"  # Change to your preferred region
}

resource "aws_s3_bucket" "emrankia" {
  bucket = "emrankiaterraform"

}

# resource "null_resource" "empty_bucket" {
#   provisioner "local-exec" {
#     command = <<EOT
#       aws s3 rm s3://${aws_s3_bucket.emrankia.bucket} --recursive
#     EOT
#   }

#   # Ensure this runs before the bucket is destroyed
#   depends_on = [aws_s3_bucket.emrankia]
# }

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.emrankia.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.emrankia.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"  # SSE-S3 for Amazon S3-managed keys
    }
    bucket_key_enabled = true  # Enable Bucket Key
  }
}

resource "aws_s3_bucket_public_access_block" "emrankia" {
  bucket = aws_s3_bucket.emrankia.bucket

  block_public_acls   = false
  block_public_policy = false
}

###########################################################################################
###########################################################################################
###########################################################################################


# # Create an SQS queue for notifications
# resource "aws_sqs_queue" "sqs_notification" {
#   name = "sqs_notification"
# }

# # Add SQS queue policy to allow S3 to send messages
# resource "aws_sqs_queue_policy" "sqs_notification_policy" {
#   queue_url = aws_sqs_queue.sqs_notification.id

#   policy = <<POLICY
# {
#   "Version": "2012-10-17",
#   "Id": "sqs_notificationPolicy",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": "*",
#       "Action": "sqs:SendMessage",
#       "Resource": "${aws_sqs_queue.sqs_notification.arn}",
#       "Condition": {
#         "ArnEquals": {
#           "aws:SourceArn": "${aws_s3_bucket.emrankia.arn}"
#         }
#       }
#     }
#   ]
# }
# POLICY
# }


###########################################################################################
###########################################################################################
###########################################################################################

# Create an SNS Topic for notifications
resource "aws_sns_topic" "sns_notification" {
  name = "S3NotificationTopic"
}

# Create SNS Topic Policy to allow S3 to publish messages to the SNS topic
resource "aws_sns_topic_policy" "sns_notification_policy" {
  arn = aws_sns_topic.sns_notification.arn

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "SNSNotificationPolicy",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sns:Publish",
      "Resource": "${aws_sns_topic.sns_notification.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_s3_bucket.emrankia.arn}"
        }
      }
    }
  ]
}
POLICY
}



# Add an email subscription to the SNS topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_notification.arn
  protocol  = "email"
  endpoint  = "emran.kia@gmail.com"
}
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
resource "aws_s3_bucket_notification" "emrankia_notification" {
  bucket = aws_s3_bucket.emrankia.id

#   queue {
#     queue_arn = aws_sqs_queue.sqs_notification.arn
#     events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*]
#   }

  topic {
    topic_arn = aws_sns_topic.sns_notification.arn
    events    = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
  }

  depends_on = [
    # aws_sqs_queue_policy.sqs_notification_policy,
    aws_sns_topic_policy.sns_notification_policy
  ]
}

