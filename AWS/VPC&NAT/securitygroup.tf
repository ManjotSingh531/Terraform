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