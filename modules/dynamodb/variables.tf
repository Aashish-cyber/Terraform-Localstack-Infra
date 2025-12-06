variable "table_name" {
  description = "DynamoDB table name"
  type        = string
  default     = "Users"
}

variable "hash_key" {
  description = "Hash key for table"
  type        = string
  default     = "UserId"
}

variable "billing_mode" {
  description = "Billing mode (PAY_PER_REQUEST or PROVISIONED)"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "attributes" {
  description = "List of attributes for the table"
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

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "localstack"
}
