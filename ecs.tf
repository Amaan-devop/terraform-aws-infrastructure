
# module "smart_ecs" {
#   source = "./modules/ECS"
#
#   app_name        = "sample-app"
#   region          = var.region
#   launch_type     = "FARGATE"
#   container_name  = "sample-app-container"
#   container_image = "nginx:latest"
#   container_port  = 80
#   task_cpu        = 256
#   task_memory     = 512
#   desired_count   = 1
#
#   # Required for FARGATE launch type
#   subnet_ids         = ["subnet-abc123", "subnet-def456"]
#   security_group_ids = ["sg-abc123"]
#   assign_public_ip   = false
# }
