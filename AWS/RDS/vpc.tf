#Custom VPC and Subnets
resource "aws_vpc" "gibs-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "gibs-vpc"
    }
}

#create public subnets in each availability zone
resource "aws_subnet" "gibs_public_subnet_1" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "gibs--public-subnet-1"
  }
}

resource "aws_subnet" "gibs_public_subnet_2" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "gibs--public-subnet-2"
  }
}

resource "aws_subnet" "gibs_public_subnet_3" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "gibs--public-subnet-3"
  }
}

#create private subnets in each availability zone
resource "aws_subnet" "gibs_private_subnet_1" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "gibs--private-subnet-1"
  }
}

resource "aws_subnet" "gibs_private_subnet_2" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-south-1b"

  tags = {
    Name = "gibs--private-subnet-2"
  }
}

resource "aws_subnet" "gibs_private_subnet_3" {
  vpc_id                  = aws_vpc.gibs-vpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "ap-south-1c"

  tags = {
    Name = "gibs--private-subnet-3"
  }
}

#create internet gateway
resource "aws_internet_gateway" "gibs_igw" {
  vpc_id = aws_vpc.gibs-vpc.id

  tags = {
    Name = "gibs-igw"
  }
}

#create public route table
resource "aws_route_table" "gibs_public_rt" {
  vpc_id = aws_vpc.gibs-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gibs_igw.id
  }

  tags = {
    Name = "gibs-public-rt"
  }
}

#create route table association for public subnets
resource "aws_route_table_association" "gibs_public_rt_assoc_1" {
  subnet_id      = aws_subnet.gibs_public_subnet_1.id
  route_table_id = aws_route_table.gibs_public_rt.id
}

resource "aws_route_table_association" "gibs_public_rt_assoc_2" {
  subnet_id      = aws_subnet.gibs_public_subnet_2.id
  route_table_id = aws_route_table.gibs_public_rt.id
}

resource "aws_route_table_association" "gibs_public_rt_assoc_3" {
  subnet_id      = aws_subnet.gibs_public_subnet_3.id
  route_table_id = aws_route_table.gibs_public_rt.id
}