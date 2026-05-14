# Terraform module for CloudFront Distribution
- Creates a CLoudfront distribution with Origin Access Control(OAC)
- Check for creating s3-cloudfront to get knownledge on how to use distribution to deploy S3+CDN

### Input Variables - 
- ```bucket_regional_domain_name```
- ```bucket_name```
- ```Environment```
- ```default_root_object```

### Output Variables - 
- ```distribution_dns```
- ```aliases```
- ```distribution_arn```