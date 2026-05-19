resource "aws_sqs_queue" "dlq" {
  count = var.enable_dlq ? 1 : 0

  name                      = join("-", [var.queue_name, "dlq"])
  message_retention_seconds = var.dlq_message_retention_seconds

  tags = {
    Environment = var.Environment
  }
}

resource "aws_sqs_queue" "main" {
  name                       = var.queue_name
  visibility_timeout_seconds = var.visibility_timeout_seconds
  message_retention_seconds  = var.message_retention_seconds
  delay_seconds              = var.delay_seconds
  max_message_size           = var.max_message_size
  receive_wait_time_seconds  = var.receive_wait_time_seconds
  fifo_queue                 = var.fifo_queue

  dynamic "redrive_policy" {
    for_each = var.enable_dlq ? [1] : []
    content {
      deadLetterTargetArn = aws_sqs_queue.dlq[0].arn
      maxReceiveCount     = var.max_receive_count
    }
  }

  tags = {
    Environment = var.Environment
  }
}

resource "aws_sns_topic" "main" {
  name         = var.topic_name
  display_name = var.topic_display_name
  fifo_topic   = var.fifo_topic

  tags = {
    Environment = var.Environment
  }
}

resource "aws_sns_topic_subscription" "sqs" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.main.arn
}

resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowSNSPublish"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.main.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.main.arn
          }
        }
      }
    ]
  })
}
