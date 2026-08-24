resource "aws_instance" "myfirstinstance" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"

    tags = {
        Name = "Gibs"
    }

    vpc_security_group_ids = var.SecurityGroup
}