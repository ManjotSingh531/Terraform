#Key pair resource
resource "aws_key_pair" "gibs_key" {
    key_name = "gibs-key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#AWS Instance
resource "aws_instance" "myfirstinstance" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    key_name = aws_key_pair.gibs_key.key_name

    vpc_security_group_ids = [aws_security_group.allow-gibs-ssh.id]
    subnet_id = aws_subnet.gibs_public_subnet_1.id

    tags = {
        Name = "Gibs"
    }
}

#Print Public IP
output "public_ip" {
    value = aws_instance.myfirstinstance.public_ip
}