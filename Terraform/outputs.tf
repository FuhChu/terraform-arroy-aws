output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app_server.public_dns
}

output "rds_endpoint" {
  description = "Endpoint of the RDS database"
  value       = aws_db_instance.main.address
}

output "rds_port" {
  description = "Port of the RDS database"
  value       = aws_db_instance.main.port
}