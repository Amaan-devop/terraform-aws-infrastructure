# Terraform module for VPC 
- Creates list of components mentioned below
    - VPC
    - 4 subnets(2 public and 2 private) 
    - Internet gateway for 2 public subnets  
    - NAT Gateway(with an elastic IP) for 1 private subnet
    - Route tables for associating all this routes 

### Input Variables -
- ```vpc_cidr ```

### Output Variables - 

- ```vpc_id```
- ```public_subnet1_id```
- ```public_subnet2_id```
- ```private_subnet1_id```
- ```private_subnet2_id```