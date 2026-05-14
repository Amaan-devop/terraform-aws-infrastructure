# terraform-aws-infrastructure

A collection of reusable Terraform modules for provisioning core AWS infrastructure. Each module is self-contained with its own variables, outputs, and documentation, making it easy to plug into any AWS environment.

## Services Covered

| Module | AWS Service | Description |
|---|---|---|
| `vpc` | Amazon VPC | Custom VPC with subnets, route tables, and internet gateway |
| `instance` | Amazon EC2 | EC2 instance with configurable AMI, type, and key pair |
| `autoscalinggroup` | Auto Scaling Group | ASG with launch template and scaling policies |
| `ECS` | Amazon ECS | ECS cluster and service setup |
| `lambda` | AWS Lambda | Lambda function with Python runtime and IAM role |
| `beanStalk` | Elastic Beanstalk | Web server environment with VPC and ELB support |
| `S3` | Amazon S3 | S3 bucket with configurable access and versioning |
| `distribution` | Amazon CloudFront | CloudFront distribution backed by an S3 origin |
| `DMS` | AWS DMS | Database Migration Service replication instance and tasks |

## Project Structure

```
.
├── main.tf                     # Provider and backend (S3) configuration
├── variables.tf                # Root-level variables
├── ECS.tf                      # ECS module call
├── asg.tf                      # Auto Scaling Group module call
├── beanstalk.tf                # Elastic Beanstalk module call
├── cloudfront-s3.tf            # S3 + CloudFront module calls
├── dms.tf                      # DMS module call
├── instance.tf                 # EC2 instance module call
├── lambda.tf                   # Lambda module call
├── s3.tf                       # S3 module call
└── modules/
    ├── vpc/                    # VPC, subnets, routing
    ├── instance/               # EC2 instance
    ├── autoscalinggroup/       # Launch template + ASG
    ├── ECS/                    # ECS cluster and service
    ├── lambda/                 # Lambda + Python source
    │   └── python/             # Lambda handler code
    ├── beanStalk/              # Elastic Beanstalk environment
    ├── S3/                     # S3 bucket
    ├── distribution/           # CloudFront distribution
    └── DMS/                    # DMS replication instance
```

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.0
- AWS CLI configured with appropriate credentials (`aws configure`)
- An S3 bucket for Terraform remote state (see [Backend Configuration](#backend-configuration))

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

  ami           = "ami-0abcdef1234567890"
  instance_type = "t3.micro"
  key_name      = "my-key-pair"
}
```

Refer to the `README.md` inside each module directory for its full list of input variables and outputs.

## Module Inputs & Outputs

Each module under `modules/` contains:
- `variables.tf` — all configurable inputs with descriptions and defaults
- `outputs.tf` — values exported for use by other modules or the root configuration
- `README.md` — module-specific usage notes

## Tech Stack

- **IaC:** Terraform (HashiCorp Configuration Language)
- **Cloud:** Amazon Web Services (AWS)
- **State Backend:** Amazon S3
- **Runtime (Lambda):** Python 3.x

