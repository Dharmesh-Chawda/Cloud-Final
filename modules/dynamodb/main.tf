resource "aws_dynamodb_table" "this" {
  name         = "${var.table_name}-${var.environment}"
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
