resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  count      = length(var.cidrs)
  vpc_id     = aws_vpc.vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.cidrs[count.index]
  tags = {
    Name = "Public Subnet -${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "Internet Gateway"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.cidrs)
  subnet_id      = aws_subnet.public_subnet_1.*.id[count.index]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    gateway_id = aws_internet_gateway.gw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Public route Table"
  }

}


resource "aws_security_group" "web-sg" {
  vpc_id = aws_vpc.vpc.id
  name   = "web-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
















