# Terraform AWS S3 and SNS Notification Setup

This Terraform configuration sets up an AWS S3 bucket with various associated resources, including S3 bucket versioning, encryption, and public access block settings. Additionally, it creates an SNS topic to receive notifications about changes to the S3 bucket. 

## Overview

### S3 Bucket Configuration
- **Module:** `s3_bucket`
- **Description:** Creates an S3 bucket with the specified name.
- **Variables:**
  - `s3b_bucket_name`: Name of the S3 bucket.

### S3 Bucket Versioning
- **Module:** `s3_bucket_versioning`
- **Description:** Configures versioning for the S3 bucket.
- **Variables:**
  - `s3bv_bucket`: ID of the S3 bucket.
  - `s3bv_status`: Status of versioning (`Enabled` or `Disabled`).

### S3 Bucket Encryption
- **Module:** `s3_bucket_encryption`
- **Description:** Configures encryption for the S3 bucket.
- **Variables:**
  - `s3bse_bucket`: ID of the S3 bucket.
  - `s3bse_sse_algorithm`: Server-side encryption algorithm (e.g., `AES256`, `aws:kms`).
  - `s3bse_bucket_key_enabled`: Whether to enable bucket keys.

### S3 Bucket Public Access Block
- **Module:** `s3_bucket_public_access_block`
- **Description:** Configures public access block settings for the S3 bucket.
- **Variables:**
  - `s3bpab_bucket`: ID of the S3 bucket.
  - `s3bpab_block_public_acls`: Block public ACLs (`true` or `false`).
  - `s3bpab_block_public_policy`: Block public bucket policies (`true` or `false`).

### SNS Topic
- **Module:** `sns_topic`
- **Description:** Creates an SNS topic for notifications.
- **Variables:**
  - `sns_name`: Name of the SNS topic.

### SNS Topic Policy
- **Module:** `sns_topic_policy`
- **Description:** Configures a policy to allow the S3 bucket to publish notifications to the SNS topic.
- **Variables:**
  - `snstp_arn`: ARN of the SNS topic.
  - `snstp_policy`: Policy document for SNS topic.

### SNS Topic Subscription
- **Module:** `sns_topic_subscription`
- **Description:** Adds an email subscription to the SNS topic.
- **Variables:**
  - `snss_topic_arn`: ARN of the SNS topic.
  - `snss_protocol`: Protocol for subscription (`email`).
  - `snss_endpoint`: Email address for subscription.

### S3 Bucket Notification
- **Module:** `s3_bucket_notification`
- **Description:** Configures S3 bucket notifications to send events to SNS.
- **Variables:**
  - `s3bkn_bucket_id`: ID of the S3 bucket.
  - `s3bkn_queue_arn`: ARN of the SQS queue (optional).
  - `s3bkn_events`: List of events to notify (e.g., `s3:ObjectCreated:*`, `s3:ObjectRemoved:*`).
  - `s3bkn_topic_arn`: ARN of the SNS topic.

## Setup Instructions

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-username/your-repo.git
   cd your-repo
