variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1" # Example region
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium" # Changed from t2.micro to ensure enough resources for builds
}

variable "ami_id" {
  description = "AMI ID for EC2 instance (Amazon Linux 2023 HVM kernel)"
  type        = string
  # Find latest Amazon Linux 2023 AMI for your region:
  # aws ec2 describe-images --owners amazon --filters 'Name=name,Values=al2023-ami-*-kernel-6.1-x86_64' 'Name=state,Values=available' --query 'sort_by(Images, &CreationDate) | [-1].ImageId'
  default     = "ami-0e104e7ad00f80a4e" # Example for us-east-1 (please update)
}

variable "key_name" {
  description = "Name of the EC2 Key Pair for SSH access"
  type        = string
  # Ensure you have created this key pair in AWS Management Console or via Terraform before applying
}

variable "db_instance_class" {
  description = "RDS DB instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  description = "RDS DB allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Username for the database"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Password for the database. Use a secure method in production!"
  type        = string
  sensitive   = true # Mark as sensitive to prevent logging
}

variable "my_ip" {
  description = "Your public IP address for SSH access restriction"
  type        = string
}