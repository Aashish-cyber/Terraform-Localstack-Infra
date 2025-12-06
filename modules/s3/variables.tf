variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "localstack-demo-bucket"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "localstack"
}

variable "enable_versioning" {
  description = "Enable versioning for bucket"
  type        = bool
  default     = false
}
