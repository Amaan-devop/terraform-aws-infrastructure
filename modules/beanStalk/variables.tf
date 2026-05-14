variable "elasticapp_name" {
  # default = "myapp"
}
variable "beanstalkappenv" {
  # default = "myenv"
}
variable "solution_stack_name" {
  type = string
}
variable "tier" {
  type = string
  # default = "WebServer"
}

variable "vpc_id" {}
variable "public_subnets" {
  type = list(string)
}
variable "elb_public_subnets" {
  type = list(string)
}
variable "instance_type" {}
