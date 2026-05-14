
# provider "aws" {
#   alias  = "mumbai"
#   region = "ap-south-1"
# }


# module "smart_beanstalk" {
#   source             = "./modules/beanStalk"
#   vpc_id             = ""
#   public_subnets     = ["", ""] # Service Subnet
#   elb_public_subnets = ["", ""] # ELB Subnet
#   tier               = "WebServer"
#   instance_type      = "t2.micro"
#   #   solution_stack_name = "64bit Amazon Linux 2 v3.2.0 running Python 3.8"
#   solution_stack_name = "64bit Amazon Linux 2023 v3.0.5 running .NET 6" # ref https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/concepts.platforms.html
#   providers = {
#     "aws" = aws.mumbai
#   }
# }
