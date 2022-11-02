output "ec2_instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "ec2_instance_public_dns_name" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.public_dns
}

output "rds_endpoint" {
  description = "RDS instance hostname"
  value       = aws_db_instance.postgres_rds.endpoint
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.postgres_rds.port
}