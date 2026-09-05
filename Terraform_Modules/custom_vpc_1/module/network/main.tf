#VPC Resource
resource "aws_vpc" "gibs_vpc" {
    cidr_block = var.cidr_vpc
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Environment = var.environment_tag
    }
}

#Internet Gateway Resource
resource "aws_internet_gateway" "gibs_igw" {
    vpc_id = aws_vpc.gibs_vpc.id

    tags = {
        Environment = var.environment_tag
    }
}

#Subnet Resource
resource "aws_subnet" "gibs_subnet" {
    vpc_id                  = aws_vpc.gibs_vpc.id
    cidr_block              = var.subnet_cidr
    map_public_ip_on_launch = true
    availability_zone       = var.availability_zone

    tags = {
        Environment = var.environment_tag
    }
}

#Route Table Resource
resource "aws_route_table" "gibs_route_table" {
    vpc_id = aws_vpc.gibs_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gibs_igw.id
    }

    tags = {
        Environment = var.environment_tag
    }
}

#Route Table Association Resource
resource "aws_route_table_association" "gibs_route_table_association" {
    subnet_id      = aws_subnet.gibs_subnet.id
    route_table_id = aws_route_table.gibs_route_table.id
}

#Security Group Resource
resource "aws_security_group" "gibs_security_group" {
    name        = "gibs_security_group"
    description = "Security group for GIBS VPC"
    vpc_id      = aws_vpc.gibs_vpc.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Environment = var.environment_tag
    }
}