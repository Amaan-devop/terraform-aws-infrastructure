# provider "aws" {
#     alias = "s3_region"
#   region = var.bucket_region
# }
# module "s3_bucket" {
#   source = "./modules/S3"
#   bucket_name = "sampleapp-test-ui-${var.bucket_region}"
#   providers = {
#     aws = aws.s3_region
#   }
# }
