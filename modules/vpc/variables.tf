
variable "vpc_cidr" {
  # default   = "192.168.29.0/24"
  sensitive = true
}

variable "subnets" {
  type    = list(string)
  default = ["public-subnet1", "public-subnet2", "private-subnet1", "private-subnet2"]
}
