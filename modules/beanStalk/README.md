# Terraform module for BeanStalk
- Creates a beanstalk application with environment

### Input Variables - 
- ```elasticapp_name```
- ```beanstalkappenv```
- ```solution_stack_name``` ref https://automateinfra.com/2021/03/24/how-to-launch-aws-elastic-beanstalk-using-terraform/
- ```tier```
- ```vpc_id```
- ```public_subnets``` (list)
- ```elb_public_subnets``` (list)
- ```instance_type```

### Output Variables - 
- ```distribution_dns```
- ```aliases```
- ```distribution_arn```