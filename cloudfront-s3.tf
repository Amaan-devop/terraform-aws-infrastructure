# provider "aws" {
#   alias  = "s3_region"
#   region = var.bucket_region
# }
# module "smart_bucket" {
#   source      = "./modules/S3"
#   bucket_name = join("-", ["testapp-dev", var.bucket_region])
# }

# module "smart_distribution" {
#   depends_on                  = [module.smart_bucket]
#   source                      = "./modules/distribution"
#   bucket_name                 = module.smart_bucket.bucket_name
#   bucket_regional_domain_name = module.smart_bucket.bucket_regional_domain_name
#   Environment                 = "Development"
# }

# resource "aws_s3_bucket_policy" "allow_access_to_cloudfront" {
#   bucket = module.smart_bucket.bucket_id
#   policy = data.aws_iam_policy_document.allow_access_to_cloudfront.json
# }

# data "aws_iam_policy_document" "allow_access_to_cloudfront" {
#   statement {
#     principals {
#       type        = "Service"
#       identifiers = ["cloudfront.amazonaws.com"]
#     }

#     actions = [
#       "s3:GetObject",
#     ]

#     resources = [
#       "${module.smart_bucket.bucket_arn}/*",
#     ]
#     condition {
#       test     = "StringEquals"
#       variable = "AWS:SourceArn"

#       values = [
#         "${module.smart_distribution.distribution_arn}"
#       ]
#     }
#   }
# }
