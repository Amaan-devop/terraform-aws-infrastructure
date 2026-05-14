output "bucket_name" {
  value = aws_s3_bucket.smart_bucket.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.smart_bucket.id
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.smart_bucket.bucket_regional_domain_name
}
output "bucket_arn" {
  value = aws_s3_bucket.smart_bucket.arn
}