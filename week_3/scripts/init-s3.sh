#!/bin/bash

# Declaring bucket name
BUCKET_NAME="svoitenko-bucket-week-3"

# Bucket creation and versioning configuration
aws s3 mb s3://$BUCKET_NAME
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration MFADelete=Disabled,Status=Enabled

# File copying from local machine to the S3 bucket
aws s3 cp rds-script.sql s3://$BUCKET_NAME/