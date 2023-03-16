




//-------------------------------VPC Code--------------------------------------//

// Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "vpc-ec2"
  }
}



// Create Public Subnet1
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "192.168.1.0/24"
  availability_zone  = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet1"
  }
}



// Create Internet Gateway
resource "aws_internet_gateway" "my_gtway" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name : "my_gtway"
  }
}

// Create RT for subnet1
resource "aws_route_table" "Public-Subnet-RT" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gtway.id
  }
  tags = {
    Name = "Route Table for IGW"
  }
}

// Associate public subnets to public RT
resource "aws_route_table_association" "RT-IG-Association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.Public-Subnet-RT.id
}



