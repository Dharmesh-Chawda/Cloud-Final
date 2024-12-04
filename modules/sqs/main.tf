resource "aws_sqs_queue" "this" {
  name                        = "${var.queue_prefix}-${var.environment}"
  message_retention_seconds   = 86400
  visibility_timeout_seconds  = 30

  tags = {
    Environment = var.environment
    App         = "MessagingApp"
  }
}
