provider "aws" {
  region = var.aws_region
}

# DynamoDB for Messages
resource "aws_dynamodb_table" "messages_table" {
  name         = "${var.dynamodb_table_prefix}-${var.environment}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "MessageID"

  attribute {
    name = "MessageID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    App         = "MessagingApp"
  }
}

# SQS for Message Queueing
resource "aws_sqs_queue" "message_queue" {
  name                        = "${var.sqs_queue_prefix}-${var.environment}"
  message_retention_seconds   = 86400
  visibility_timeout_seconds  = 30
}

# API Gateway
resource "aws_api_gateway_rest_api" "api" {
  name        = "MessagingAppAPI"
  description = "API for Messaging Application"
}

resource "aws_api_gateway_resource" "messages" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "messages"
}

resource "aws_api_gateway_method" "post_message" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.messages.id
  http_method   = "POST"
  authorization = "NONE"
}

# Lambda for Backend Logic
resource "aws_lambda_function" "backend" {
  function_name = "${var.lambda_function_name}-${var.environment}"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn
  filename      = "lambda.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.messages_table.name
      SQS_QUEUE_URL  = aws_sqs_queue.message_queue.id
    }
  }

  tags = {
    Environment = var.environment
    App         = "MessagingApp"
  }
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# CloudWatch Log Group for Lambda
resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${aws_lambda_function.backend.function_name}"
  retention_in_days = 7
}
