# module "notifications" {
#   source = "./modules/SNS_SQS"

#   topic_name   = "my-notifications"
#   queue_name   = "my-notifications-queue"
#   Environment  = "dev"

#   # Optional overrides
#   enable_dlq                 = true
#   max_receive_count          = 3
#   visibility_timeout_seconds = 30
#   message_retention_seconds  = 345600
#   dlq_message_retention_seconds = 1209600
# }
