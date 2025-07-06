terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"

  # Remote backend configuration for state file management
  backend "s3" {
    bucket         = "your-terraform-state-bucket-unique-name" # Replace with your unique S3 bucket name
    key            = "docker-aws-project/terraform.tfstate"
    region         = "us-east-1" # Or your preferred region
    dynamodb_table = "terraform-lock-table" # For state locking
    encrypt        = true
  }
}