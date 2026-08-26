resource "aws_security_group" "allow-gibs-ssh" {
    vpc_id      = aws_vpc.gibs-vpc.id
    name        = "allow-gibs-ssh"
    description = "Allow SSH inbound traffic"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH from anywhere"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "allow-gibs-ssh"
    }
}

#Seccurity group for MariaDB
resource "aws_security_group" "allow-mariadb" {
    vpc_id      = aws_vpc.gibs-vpc.id
    name        = "allow-mariadb"
    description = "Security Group for MariaDB"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH from anywhere"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        security_groups = [aws_security_group.allow-gibs-ssh.id]
    }

    tags = {
        Name = "allow-mariadb"
    }
}