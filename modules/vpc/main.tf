resource "aws_vpc" "vpc-app" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "vpc-app"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets-app" {
  count                   = 4
  cidr_block              = cidrsubnet(aws_vpc.vpc-app.cidr_block, 4, count.index + 1)
  availability_zone       = data.aws_availability_zones.available.names[count.index >= 2 ? (count.index) - 2 : count.index]
  vpc_id                  = aws_vpc.vpc-app.id
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.subnets[count.index]}"
  }
}

resource "aws_internet_gateway" "IGW-app" {
  vpc_id = aws_vpc.vpc-app.id
  tags = {
    Name = "IGW-app"
  }
}

resource "aws_eip" "Nat-Gateway-EIP" {
  domain     = "vpc"
  depends_on = [aws_route_table_association.subnet-association-pub]
  tags = {
    Name = "EIP-app"
  }
}

resource "aws_nat_gateway" "NAT-GATEWAY-app" {
  # depends_on = [
  #   aws_eip.Nat-Gateway-EIP
  # ]
  allocation_id = aws_eip.Nat-Gateway-EIP.id

  subnet_id = aws_subnet.subnets-app[0].id
  tags = {
    Name = "Nat-Gateway-app"
  }
}

resource "aws_route_table" "RT-pub" {
  vpc_id = aws_vpc.vpc-app.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW-app.id
  }
  tags = {
    Name = "RT-pub"
  }
}

resource "aws_route_table_association" "subnet-association-pub" {
  subnet_id      = aws_subnet.subnets-app[count.index].id
  route_table_id = aws_route_table.RT-pub.id
  count          = 2

}

resource "aws_route_table" "RT-private1" {
  vpc_id = aws_vpc.vpc-app.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-GATEWAY-app.id
  }
  tags = {
    Name = "RT-private1"
  }
}

resource "aws_route_table_association" "subnet-association-private1-nat" {
  depends_on = [
    aws_route_table.RT-private1
  ]
  subnet_id      = aws_subnet.subnets-app[2].id
  route_table_id = aws_route_table.RT-private1.id
}

resource "aws_route_table" "RT-private2" {
  vpc_id = aws_vpc.vpc-app.id
  tags = {
    Name = "RT-private2"
  }
}

resource "aws_route_table_association" "subnet-association-private2" {
  subnet_id      = aws_subnet.subnets-app[3].id
  route_table_id = aws_route_table.RT-private2.id
}