# Common
variable "Environment" {}

# SNS
variable "topic_name" {}

variable "topic_display_name" {
  default = ""
}

variable "fifo_topic" {
  default = false
}

# SQS
variable "queue_name" {}

variable "fifo_queue" {
  default = false
}

variable "visibility_timeout_seconds" {
  default = 30
}

variable "message_retention_seconds" {
  default = 345600 # 4 days
}

variable "delay_seconds" {
  default = 0
}

variable "max_message_size" {
  default = 262144 # 256 KB
}

variable "receive_wait_time_seconds" {
  default = 0
}

# Dead Letter Queue
variable "enable_dlq" {
  default = true
}

variable "max_receive_count" {
  default = 3
}

variable "dlq_message_retention_seconds" {
  default = 1209600 # 14 days
}
