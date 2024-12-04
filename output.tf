# Output for DynamoDB Table Name
output "dynamodb_table_name" {
  value = aws_dynamodb_table.messages_table.name
}

# Output for SQS Queue URL
output "sqs_queue_url" {
  value = aws_sqs_queue.message_queue.id
}

# Output for Lambda Function ARN
output "lambda_function_arn" {
  value = aws_lambda_function.backend.arn
}

# Output for API Gateway Endpoint
output "api_gateway_endpoint" {
  value = aws_api_gateway_rest_api.api.execution_arn
}
