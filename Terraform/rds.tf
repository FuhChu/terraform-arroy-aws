resource "aws_db_subnet_group" "default" {
  name       = "main-rds-subnet-group"
  subnet_ids = data.aws_subnet_ids.default_subnets.ids
  description = "Subnet group for RDS instance"
}

resource "aws_db_instance" "main" {
  allocated_storage    = var.db_allocated_storage
  engine               = "postgres"
  engine_version       = "15.5" # Or a suitable version
  instance_class       = var.db_instance_class
  identifier           = "my-app-db"
  username             = var.db_username
  password             = var.db_password
  db_name              = var.db_name
  skip_final_snapshot  = true
  publicly_accessible  = false # Best practice: keep RDS not publicly accessible
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  multi_az             = false # For assessment, single AZ is fine
  storage_type         = "gp2" # General Purpose SSD

  tags = {
    Name = "MyWebAppDB"
  }
}