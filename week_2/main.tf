terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami                  = var.instance_amiId
  instance_type        = var.instance_type
  key_name             = var.instance_key_name
  iam_instance_profile = aws_iam_instance_profile.s3_instance_profile.name
  security_groups      = ["HTTP_SG_Terraform", "SSH_SG_Terraform"]
  user_data            = <<-EOF
              #!/bin/bash
              aws s3 cp s3://${var.s3_bucket_name}/${var.file_key_s3} /home/ec2-user/${var.file_key_s3}
              chown ec2-user ${var.file_key_s3}
	EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_security_group" "http_sg" {
  name = "HTTP_SG_Terraform"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ssh_sg" {
  name = "SSH_SG_Terraform"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

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