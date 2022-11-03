resource "aws_iam_role" "s3_access_role" {
  name = "s3_rwl_role_terraform"
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
  role = aws_iam_role.s3_access_role.id

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

resource "aws_iam_instance_profile" "s3_instance_profile" {
  name = "s3_rwl_instance_profile"
  role = aws_iam_role.s3_access_role.name
}