output "sns_topic_arn" {
  value = aws_sns_topic.main.arn
}

output "sns_topic_name" {
  value = aws_sns_topic.main.name
}

output "sqs_queue_arn" {
  value = aws_sqs_queue.main.arn
}

output "sqs_queue_url" {
  value = aws_sqs_queue.main.id
}

output "sqs_dlq_arn" {
  value = var.enable_dlq ? aws_sqs_queue.dlq[0].arn : null
}

output "sqs_dlq_url" {
  value = var.enable_dlq ? aws_sqs_queue.dlq[0].id : null
}
