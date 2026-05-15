variable "instance_type" {
  default = "dms.t3.micro"
  type    = string
}


variable "subnet_id" {
  type    = string
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "storage_size" {
  type    = number
  default = 100
}

variable "instance_id" {
  type = string
}