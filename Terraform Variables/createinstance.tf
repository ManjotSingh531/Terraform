resource "aws_instance" "myfirstinstance" {
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"

    tags = {
        Name = "Gibs"
    }
    vpc_security_group_ids = var.SecurityGroup
}