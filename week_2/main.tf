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
  iam_instance_profile = var.instance_profile
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