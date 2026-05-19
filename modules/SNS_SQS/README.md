# Terraform module for SNS and SQS
- Creates an SNS Topic and an SQS Queue with the topic subscribed to the queue
- Attaches an SQS queue policy allowing the SNS topic to publish messages
- Optionally creates a Dead Letter Queue (DLQ) with a redrive policy

### Input Variables -
- `topic_name` (required)
- `queue_name` (required)
- `Environment` (required)
- `topic_display_name` (default: `""`)
- `fifo_topic` (default: `false`)
- `fifo_queue` (default: `false`)
- `visibility_timeout_seconds` (default: `30`)
- `message_retention_seconds` (default: `345600`)
- `delay_seconds` (default: `0`)
- `max_message_size` (default: `262144`)
- `receive_wait_time_seconds` (default: `0`)
- `enable_dlq` (default: `true`)
- `max_receive_count` (default: `3`)
- `dlq_message_retention_seconds` (default: `1209600`)

### Output Variables -
- `sns_topic_arn`
- `sns_topic_name`
- `sqs_queue_arn`
- `sqs_queue_url`
- `sqs_dlq_arn`
- `sqs_dlq_url`

### Example Usage -
```hcl
module "notifications" {
  source = "./modules/SNS_SQS"

  topic_name   = "my-notifications"
  queue_name   = "my-notifications-queue"
  Environment  = "dev"
  enable_dlq   = true
}
```
