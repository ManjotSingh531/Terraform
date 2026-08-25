#create External NAT Gateway
resource "aws_eip" "gibs_nat_eip" {
    domain = "vpc"
    
    tags = {
        Name = "gibs-nat-eip"
    }
}

#public subnet dependency for NAT Gateway
resource "aws_nat_gateway" "gibs_nat_gateway" {
    allocation_id = aws_eip.gibs_nat_eip.id
    subnet_id     = aws_subnet.gibs_public_subnet_1.id
    depends_on    = [aws_internet_gateway.gibs_igw]
}

#create route table for private subnets
resource "aws_route_table" "gibs_private_route_table" {
    vpc_id = aws_vpc.gibs-vpc.id
    route {
        cidr_block     = "0.0.0/0"
        nat_gateway_id = aws_nat_gateway.gibs_nat_gateway.id
    }

    tags = {
        Name = "gibs-private-route-table"
    }
}

#associate private subnets with the private route table
resource "aws_route_table_association" "gibs_private_subnet_1_association" {
    subnet_id      = aws_subnet.gibs_private_subnet_1.id
    route_table_id = aws_route_table.gibs_private_route_table.id
}

resource "aws_route_table_association" "gibs_private_subnet_2_association" {
    subnet_id      = aws_subnet.gibs_private_subnet_2.id
    route_table_id = aws_route_table.gibs_private_route_table.id
}

resource "aws_route_table_association" "gibs_private_subnet_3_association" {
    subnet_id      = aws_subnet.gibs_private_subnet_3.id
    route_table_id = aws_route_table.gibs_private_route_table.id
}