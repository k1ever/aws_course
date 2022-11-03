#!/bin/bash

# Declaring DynamoDB table name
TABLE_NAME="aws_students"

# List tables
aws dynamodb list-tables --region us-west-2

# Put item into the table
echo "INSERTING DATA TO DYNAMODB TABLE $TABLE_NAME"
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"1"}, "name":{"S":"Sergii"}}' --region us-west-2
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"2"}, "name":{"S":"Anna"}}' --region us-west-2
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"3"}, "name":{"S":"Mitya"}}' --region us-west-2
echo "DATA INSERTION COMPLETED"

# Get items from the table
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"3"}}' --region us-west-2
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"2"}}' --region us-west-2
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"1"}}' --region us-west-2
aws dynamodb scan --table-name $TABLE_NAME --region us-west-2