variable "queue_prefix" {
  description = "Prefix for the SQS queue name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}
