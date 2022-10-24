#!/bin/bash
echo "AWS course is awesome!" > test_file.txt
BUCKET_NAME="svoitenko-bucket-1"
aws s3api create-bucket --bucket $BUCKET_NAME --create-bucket-configuration LocationConstraint=us-west-2
aws s3api create-bucket --bucket $BUCKET_NAME --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket $BUCKET_NAME --versioning-configuration MFADelete=Disabled,Status=Enabled
aws s3 cp test_file.txt s3://$BUCKET_NAME/
aws s3 ls s3://$BUCKET_NAME/
