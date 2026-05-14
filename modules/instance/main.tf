resource "aws_instance" "smart_instance" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags = {
    Name        = var.instance_name
    Description = "testing from terraform"
    CreatedBy   = "terraform"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install nginx -y
              systemctl enable nginx
              systemctl start nginx
              EOF

  key_name = aws_key_pair.smart_key_pair.id

  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "smart_key_pair" {
  key_name   = join("-", [var.instance_name, "key"])
  public_key = file("/home/ubuntu/.ssh/app-key.pub") ## this key is stored locally in my machine
}


resource "aws_security_group" "ssh-access" {
  name        = join("-", [var.instance_name, "ssh-access"])
  description = "allow ssh sccess from the internet"
  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    protocol    = "all"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
