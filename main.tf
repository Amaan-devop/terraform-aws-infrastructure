

terraform {
  backend "s3" {
    bucket = "amaan-test-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-2"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}
provider "aws" {
  region = "ap-south-2"
}

# provider "aws" {
#   alias  = "mumbai"
#   region = "ap-south-1"
# }


# module "sample-vpc" {
#   source = "./modules/vpc"

#   # vpc_cidr = count.index % 2 == 0 ? "10.10.10.0/24" : "10.10.10.0/28"
#   # count    = 2
# }
# module "sample-vpc-2" {
#   source = "./modules/vpc"

#   vpc_cidr = "10.10.10.0/24"
# #   providers = {
# #     aws = aws.mumbai
# #   }
# }

