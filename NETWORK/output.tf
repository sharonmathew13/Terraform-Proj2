output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "web_sg" {
  value = aws_security_group.web-sg.id
}

output "public_subnet_1" {
  value = aws_subnet.public_subnet_1.*.id

}