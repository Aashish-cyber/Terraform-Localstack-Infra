resource "aws_dynamodb_table" "table" {
  name         = var.table_name
  hash_key     = var.hash_key
  billing_mode = var.billing_mode

  dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
  }

  tags = {
    Name        = var.table_name
    Environment = var.environment
  }
}
