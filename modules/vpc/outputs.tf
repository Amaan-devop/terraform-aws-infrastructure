output "vpc_id" {
  value = aws_vpc.vpc-app.id
}

output "public_subnet1_id" {
  value = aws_subnet.subnets-app[0].id
}
output "public_subnet2_id" {
  value = aws_subnet.subnets-app[1].id
}

output "private_subnet1_id" {
  value = aws_subnet.subnets-app[2].id
}
output "private_subnet2_id" {
  value = aws_subnet.subnets-app[3].id
}