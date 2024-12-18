# Networking #

resource "aws_vpc" "app" {
  cidr_block = var.ips[0]
  tags = {
    Name = "app"
  }
}

resource "aws_subnet" "public_subnet1" {
  cidr_block              = var.ips[1]
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  cidr_block              = var.ips[2]
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
    tags = {
    Name = "private_subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  cidr_block              = var.ips[3]
  vpc_id                  = aws_vpc.app.id
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
    tags = {
    Name = "private_subnet3"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "gw"
  }
}

# ROUTING #
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

 tags = {
    Name = "rt"
  }
}

resource "aws_route_table_association" "app_subnets" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rt.id
}


