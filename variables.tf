# AWS Provider Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS access key"
  type        = string
  sensitive   = true
  default     = "test"
}

variable "aws_secret_key" {
  description = "AWS secret key"
  type        = string
  sensitive   = true
  default     = "test"
}

# Common Variables
variable "environment" {
  description = "Environment name"
  type        = string
  default     = "localstack"
}

variable "availability_zone" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1a"
}

# VPC Module Variables
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# EC2 Module Variables
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# S3 Module Variables
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "localstack-demo-bucket"
}

variable "enable_versioning" {
  description = "Enable versioning for S3 bucket"
  type        = bool
  default     = false
}

# DynamoDB Module Variables
variable "dynamodb_table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "Users"
}

variable "dynamodb_hash_key" {
  description = "DynamoDB table hash key"
  type        = string
  default     = "UserId"
}

variable "dynamodb_billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "dynamodb_attributes" {
  description = "DynamoDB table attributes"
  type = list(object({
    name = string
    type = string
  }))
  default = [
    {
      name = "UserId"
      type = "S"
    }
  ]
}
