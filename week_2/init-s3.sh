#!/bin/bash

# File creation
echo "AWS course is awesome!" > test_file.txt

# Declaring bucket name
BUCKET_NAME="svoitenko-bucket-1"

# Bucket creation and versioning configuration
aws s3api create-bucket --bucket $BUCKET_NAME --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration MFADelete=Disabled,Status=Enabled

# File copying from local machine to the S3 bucket
aws s3 cp test_file.txt s3://$BUCKET_NAME/

