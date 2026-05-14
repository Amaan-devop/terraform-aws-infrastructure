output "distribution_dns" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}
output "aliases" {
  value = aws_cloudfront_distribution.s3_distribution.aliases
}
output "distribution_arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}