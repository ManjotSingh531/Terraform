data "aws_availability_zones" "available" {}

data "aws_ami" "ubuntu" {
    most_recent = true
    owners = ["099720109477"]

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

resource "aws_instance" "myfirstinstance" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t3.micro"
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "Gibs"
    }

    vpc_security_group_ids = var.SecurityGroup
}