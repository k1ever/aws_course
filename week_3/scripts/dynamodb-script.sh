#!/bin/bash

# Declaring bucket name
TABLE_NAME="aws_students"

# List tables
aws dynamodb list-tables --region us-west-2

# Put item into the table
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"1"}, "name":{"S":"Sergii"}}' --region us-west-2
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"2"}, "name":{"S":"Anna"}}' --region us-west-2
aws dynamodb put-item --table-name $TABLE_NAME --item '{"id": {"N":"3"}, "name":{"S":"Mitya"}}' --region us-west-2

# Get items from the table
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"3"}}' --region us-west-2
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"2"}}' --region us-west-2
aws dynamodb get-item --table-name $TABLE_NAME --key '{"id": {"N":"1"}}' --region us-west-2
aws dynamodb scan --table-name $TABLE_NAME --region us-west-2