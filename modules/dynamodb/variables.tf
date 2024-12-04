variable "table_name" {
  description = "Prefix for the DynamoDB table name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}
