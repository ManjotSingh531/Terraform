module "web_server" {
    source = "./modules/ec2"

    name = "gibs-ec2-instance"
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    security_group_ids = [aws_security_group.gibs-ec2-sg.id]
}