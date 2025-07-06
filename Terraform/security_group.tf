resource "aws_security_group" "ec2_sg" {
  name        = "ec2-app-security-group"
  description = "Allow SSH and HTTP access to EC2 instance"
  vpc_id      = data.aws_vpc.default.id # Using default VPC for simplicity

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip}/32"] # Restrict SSH to your IP
    description = "SSH access from my IP"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
    description = "HTTP access from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "ec2-app-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-database-security-group"
  description = "Allow traffic from EC2 instance to RDS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = 5432 # PostgreSQL default port
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id] # Allow traffic from EC2 SG
    description     = "Allow PostgreSQL access from EC2 instance"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "rds-db-sg"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default_subnets" {
  vpc_id = data.aws_vpc.default.id
}