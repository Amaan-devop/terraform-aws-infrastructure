variable "instance_ami" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_name" {}

variable "ssh_public_key_path" {
  type = string
}

variable "ssh_allowed_cidr" {
  type = string
}

