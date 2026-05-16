# Terraform module for ECS
- Creates an ECS cluster with optional CloudWatch Container Insights
- Creates a task definition supporting both FARGATE and EC2 launch types
- Creates an ECS service to run and maintain the desired number of task instances
- Creates a task execution IAM role with the AWS managed `AmazonECSTaskExecutionRolePolicy`
- Creates a CloudWatch log group (`/ecs/<app_name>`) wired into the container's log driver

## Creation Steps -
- Choose a `launch_type`: `FARGATE` (default) or `EC2`
- Provide the Docker image URI via `container_image` (ECR URI or public image e.g. `nginx:latest`)
- For **FARGATE**: supply `subnet_ids` and `security_group_ids` from your VPC
- For **EC2**: ensure an EC2 Container Instance is registered to the cluster before applying
- Uncomment and fill in the `module "smart_ecs"` block in `ecs.tf` at the root, then run:
  ```bash
  terraform init
  terraform plan
  terraform apply
  ```

### Input Variables -
- ```app_name``` — prefix used for all resource names
- ```region``` — AWS region for CloudWatch log group (default: `ap-south-2`)
- ```launch_type``` — `FARGATE` or `EC2` (default: `FARGATE`)
- ```enable_container_insights``` — enable CloudWatch Container Insights (default: `true`)
- ```task_cpu``` — CPU units for the task, 1 vCPU = 1024 (default: `256`)
- ```task_memory``` — memory in MiB for the task (default: `512`)
- ```container_name``` — name of the container inside the task definition
- ```container_image``` — Docker image URI to run
- ```container_cpu``` — CPU units reserved for the container (default: `256`)
- ```container_memory``` — memory in MiB reserved for the container (default: `512`)
- ```container_port``` — port exposed by the container (default: `80`)
- ```desired_count``` — number of task instances to keep running (default: `1`)
- ```subnet_ids``` — list of subnet IDs for Fargate network configuration
- ```security_group_ids``` — list of security group IDs for Fargate network configuration
- ```assign_public_ip``` — assign a public IP to Fargate tasks (default: `false`)

### Output Variables -
- ```cluster_id```
- ```cluster_arn```
- ```cluster_name```
- ```task_definition_arn```
- ```task_definition_family```
- ```service_name```
- ```service_id```
- ```execution_role_arn```
