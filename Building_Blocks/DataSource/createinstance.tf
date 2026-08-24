data "aws_availability_zones" "available" {}

resource "aws_instance" "myfirstinstance" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
        Name = "Gibs"
    }

    vpc_security_group_ids = var.SecurityGroup
}