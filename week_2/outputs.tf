output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "instance_public_dns_name" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.public_dns
}
