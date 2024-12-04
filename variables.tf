# Environment Variable
variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

# Region for AWS Provider
variable "aws_region" {
  description = "AWS region for deploying resources"
  type        = string
  default     = "us-west-2"
}

# DynamoDB Table Name Prefix
variable "dynamodb_table_prefix" {
  description = "Prefix for the DynamoDB table name"
  type        = string
  default     = "MessagesTable"
}

# SQS Queue Name Prefix
variable "sqs_queue_prefix" {
  description = "Prefix for the SQS queue name"
  type        = string
  default     = "MessageQueue"
}

# Lambda Function Name
variable "lambda_function_name" {
  description = "Name of the Lambda function for backend logic"
  type        = string
  default     = "MessagingAppBackend"
}
