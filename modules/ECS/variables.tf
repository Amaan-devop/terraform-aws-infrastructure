variable "app_name" {
  type        = string
  description = "Application name used as a prefix for all resource names"
}

variable "region" {
  type        = string
  description = "AWS region for CloudWatch log group"
  default     = "ap-south-2"
}

variable "launch_type" {
  type        = string
  description = "ECS launch type: FARGATE or EC2"
  default     = "FARGATE"
}

variable "enable_container_insights" {
  type        = bool
  description = "Enable CloudWatch Container Insights on the cluster"
  default     = true
}

variable "task_cpu" {
  type        = number
  description = "CPU units for the task (1 vCPU = 1024 units)"
  default     = 256
}

variable "task_memory" {
  type        = number
  description = "Memory in MiB for the task"
  default     = 512
}

variable "container_name" {
  type        = string
  description = "Name of the container within the task definition"
}

variable "container_image" {
  type        = string
  description = "Docker image URI (e.g. nginx:latest or ECR URI)"
}

variable "container_cpu" {
  type        = number
  description = "CPU units reserved for the container"
  default     = 256
}

variable "container_memory" {
  type        = number
  description = "Memory in MiB reserved for the container"
  default     = 512
}

variable "container_port" {
  type        = number
  description = "Port exposed by the container"
  default     = 80
}

variable "desired_count" {
  type        = number
  description = "Number of task instances to run in the service"
  default     = 1
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the ECS service network configuration (required for FARGATE)"
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for the ECS service network configuration (required for FARGATE)"
  default     = []
}

variable "assign_public_ip" {
  type        = bool
  description = "Assign a public IP to Fargate tasks"
  default     = false
}

# variable "target_group_arn" {
#   type        = string
#   description = "ARN of the ALB target group to attach to the service"
#   default     = ""
# }
