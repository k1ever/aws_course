resource "aws_iam_role" "ec2_access_role" {
  name = "ec2_access_role_s3_dynamo_db"
  path = "/"

  assume_role_policy = <<EOF
    {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "",
              "Effect": "Allow",
              "Principal": {
                 "Service": "ec2.amazonaws.com"
              },
              "Action": "sts:AssumeRole"
          }
      ]
    }
  EOF
}

resource "aws_iam_role_policy" "s3_code_bucket_access_policy" {
  name = "s3_code_bucket_access_policy"
  role = aws_iam_role.ec2_access_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
              "Effect": "Allow",
              "Action": [
                  "s3:ListAllMyBuckets",
                  "s3:GetBucketLocation"
              ],
              "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": ["s3:ListBucket"],
        "Resource": ["arn:aws:s3:::${var.s3_bucket_name}"]
      },
      {
        "Effect": "Allow",
        "Action": [
          "s3:PutObject",
          "s3:GetObject",
          "s3:DeleteObject"
        ],
        "Resource": ["arn:aws:s3:::${var.s3_bucket_name}/*"]
      }
    ]
  }
EOF
}

resource "aws_iam_role_policy" "dynamodb_table_access_policy" {
  name = "dynamodb_table_access_policy"
  role = aws_iam_role.ec2_access_role.id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ListAndDescribe",
            "Effect": "Allow",
            "Action": [
                "dynamodb:List*",
                "dynamodb:DescribeReservedCapacity*",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeTimeToLive"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SpecificTable",
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGet*",
                "dynamodb:DescribeStream",
                "dynamodb:DescribeTable",
                "dynamodb:Get*",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:BatchWrite*",
                "dynamodb:CreateTable",
                "dynamodb:Delete*",
                "dynamodb:Update*",
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/${var.dynamodb_table_name}"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec_instance_profile_s3_dynamodb"
  role = aws_iam_role.ec2_access_role.name
}