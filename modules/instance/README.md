# Terraform module for instance
- Creates an instance with some user data(current it installs nginx)
- Creates security group for the instance 
- Creates a key-pair for the instance 

## Creation Steps -
- create a ssh key in local machine
- modify the line which uses key in the template(smart_key_pair)

### Input Variables - 
- ```instance_ami```
- ```instance_type``` by default its t2.micro(Free-tier eligible)
- ```instance_name```

### Output Variables - 
- ```instance_public_ip```
- ```instance_id```