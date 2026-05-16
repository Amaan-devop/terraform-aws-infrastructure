# terraform-aws-infrastructure

A collection of reusable Terraform modules for provisioning core AWS infrastructure. Each module is self-contained with its own variables, outputs, and documentation, making it easy to plug into any AWS environment.

## Services Covered

| Module | AWS Service | Description |
|---|---|---|
| `vpc` | Amazon VPC | Custom VPC with subnets, route tables, NAT gateway, and internet gateway |
| `instance` | Amazon EC2 | EC2 instance with configurable AMI, type, key pair, and SSH CIDR |
| `autoscalinggroup` | Auto Scaling Group | ASG with configurable launch template (AMI and instance type as variables) |
| `lambda` | AWS Lambda | Lambda function with Python 3.12 runtime and IAM role |
| `beanStalk` | Elastic Beanstalk | Web server environment with VPC, instance subnets, and ELB subnet support |
| `S3` | Amazon S3 | S3 bucket with configurable access and versioning |
| `distribution` | Amazon CloudFront | CloudFront distribution backed by an S3 origin |
| `DMS` | AWS DMS | Database Migration Service replication instance and tasks |
| `ECS` | Amazon ECS | ECS cluster, Fargate/EC2 task definition, service, and execution IAM role |

## Project Structure

```
.
├── main.tf                     # Provider and backend (S3) configuration
├── variables.tf                # Root-level variables
├── asg.tf                      # Auto Scaling Group module call
├── beanstalk.tf                # Elastic Beanstalk module call
├── cloudfront-s3.tf            # S3 + CloudFront module calls
├── dms.tf                      # DMS module call
├── instance.tf                 # EC2 instance module call
├── ecs.tf                      # ECS cluster + service module call
├── lambda.tf                   # Lambda module call
├── s3.tf                       # S3 module call
└── modules/
    ├── vpc/                    # VPC, subnets, routing
    ├── instance/               # EC2 instance
    ├── autoscalinggroup/       # Launch template + ASG
    ├── ECS/                    # ECS cluster, task definition, service, IAM
    ├── lambda/                 # Lambda + Python source
    │   └── python/             # Lambda handler code
    ├── beanStalk/              # Elastic Beanstalk environment
    ├── S3/                     # S3 bucket
    ├── distribution/           # CloudFront distribution
    └── DMS/                    # DMS replication instance
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS provider `~> 5.0` (pinned in `main.tf` — run `terraform init -upgrade` if upgrading from an older provider)
- AWS CLI configured with appropriate credentials (`aws configure`)
- An S3 bucket for Terraform remote state (see [Backend Configuration](#backend-configuration))
- An SSH public key on disk to supply as `ssh_public_key_path` when using the `instance` module

## Backend Configuration

State is stored remotely in S3. Update `main.tf` with your own bucket details before initialising:

```hcl
terraform {
  backend "s3" {
    bucket = "<your-state-bucket>"
    key    = "terraform.tfstate"
    region = "<your-region>"
  }
}
```

## Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# 2. Initialise Terraform (downloads providers and configures backend)
terraform init

# 3. Review the execution plan
terraform plan

# 4. Apply the configuration
terraform apply
```

## Using Individual Modules

Each module can be used independently. Example — spinning up an EC2 instance:

```hcl
module "my_instance" {
  source = "./modules/instance"

  instance_ami        = "ami-0abcdef1234567890"
  instance_type       = "t3.micro"
  instance_name       = "my-app"
  ssh_public_key_path = "~/.ssh/my-key.pub"
  ssh_allowed_cidr    = "203.0.113.10/32"  # replace with your IP
}
```

Example — deploying an Auto Scaling Group:

```hcl
module "my_asg" {
  source = "./modules/autoscalinggroup"

  app_name      = "my-app"
  ami_id        = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  subnets       = ["subnet-abc123", "subnet-def456"]
}
```

Example — deploying a Lambda function:

```hcl
module "my_lambda" {
  source = "./modules/lambda"

  function_name = "my-app-processor"
}
```

Example — deploying an ECS Fargate cluster and service:

```hcl
module "my_ecs" {
  source = "./modules/ECS"

  app_name        = "my-app"
  region          = "ap-south-2"
  launch_type     = "FARGATE"
  container_name  = "my-app-container"
  container_image = "nginx:latest"
  container_port  = 80
  task_cpu        = 256
  task_memory     = 512
  desired_count   = 1

  subnet_ids         = ["subnet-abc123", "subnet-def456"]
  security_group_ids = ["sg-abc123"]
  assign_public_ip   = false
}
```

> **ECS note:** `ecs.tf` is commented out by default. Populate `subnet_ids` and `security_group_ids` with values from your VPC before enabling it.

> **DMS note:** `dms.tf` contains placeholder values (`subnet_id = "sb-abc"`, `security_group_ids = ["sg-123", "sg-abc"]`). Replace these with real subnet and security group IDs from your AWS account before running `terraform apply`.

Refer to each module's `variables.tf` for the full list of inputs and defaults.

## Module Inputs & Outputs

Each module under `modules/` contains:
- `variables.tf` — all configurable inputs with descriptions and defaults
- `outputs.tf` — values exported for use by other modules or the root configuration
- `README.md` — module-specific usage notes

## Tech Stack

- **IaC:** Terraform (HashiCorp Configuration Language)
- **Cloud:** Amazon Web Services (AWS)
- **State Backend:** Amazon S3
- **Runtime (Lambda):** Python 3.12

