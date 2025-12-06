# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = module.vpc.public_subnet_id
}

output "internet_gateway_id" {
  description = "Internet Gateway ID"
  value       = module.vpc.internet_gateway_id
}

# EC2 Outputs
output "ec2_host_id" {
  description = "EC2 host ID"
  value       = module.ec2.ec2_host_id
}

output "instance_type" {
  description = "Instance type"
  value       = module.ec2.instance_type
}

# S3 Outputs
output "s3_bucket_id" {
  description = "S3 bucket ID"
  value       = module.s3.bucket_id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = module.s3.bucket_arn
}

# DynamoDB Outputs
output "dynamodb_table_name" {
  description = "DynamoDB table name"
  value       = module.dynamodb.table_name
}

output "dynamodb_table_arn" {
  description = "DynamoDB table ARN"
  value       = module.dynamodb.table_arn
}

output "dynamodb_table_id" {
  description = "DynamoDB table ID"
  value       = module.dynamodb.table_id
}
