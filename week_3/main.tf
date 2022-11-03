resource "aws_instance" "app_server" {
  ami                         = var.instance_amiId
  instance_type               = var.instance_type
  key_name                    = var.instance_key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups             = [aws_security_group.http_sg.name, aws_security_group.ssh_sg.name]
  user_data_replace_on_change = true
  user_data                   = <<-EOF
              #!/bin/bash

              sudo yum update -y
              sudo yum install postgresql -y

              aws s3 cp s3://${var.s3_bucket_name}/rds-script.sql /home/ec2-user/rds-script.sql
              chown ec2-user rds-script.sql

              aws s3 cp s3://${var.s3_bucket_name}/dynamodb-script.sh /home/ec2-user/dynamodb-script.sh
              chown ec2-user dynamodb-script.sh
              sudo chmod +x dynamodb-script.sh
  EOF

  tags = {
    Name = var.instance_name
  }
}