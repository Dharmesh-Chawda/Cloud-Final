resource "aws_lambda_function" "this" {
  function_name = "${var.function_name}-${var.environment}"
  runtime       = "python3.8"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_exec.arn
  filename      = "lambda.zip"

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table
      SQS_QUEUE_URL  = var.sqs_queue_url
    }
  }

  tags = {
    Environment = var.environment
    App         = "MessagingApp"
  }
}

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
