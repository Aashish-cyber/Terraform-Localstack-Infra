terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  s3_use_path_style = true

  endpoints {
    s3       = "http://localhost:4566"
    dynamodb = "http://localhost:4566"
    ec2      = "http://localhost:4566"
    iam      = "http://localhost:4566"
    sts      = "http://localhost:4566"
  }
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  environment        = var.environment
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  instance_type     = var.instance_type
  availability_zone = var.availability_zone
  instance_name     = "${var.environment}-instance"
}

# S3 Module
module "s3" {
  source = "./modules/s3"

  bucket_name       = var.bucket_name
  environment       = var.environment
  enable_versioning = var.enable_versioning
}

# DynamoDB Module
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name   = var.dynamodb_table_name
  hash_key     = var.dynamodb_hash_key
  billing_mode = var.dynamodb_billing_mode
  attributes   = var.dynamodb_attributes
  environment  = var.environment
}
