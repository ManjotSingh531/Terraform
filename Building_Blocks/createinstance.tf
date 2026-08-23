resource "aws_key_pair" "flolki_key" {
    key_name = "floki"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}
resource "aws_instance" "myfirstinstance" {
    ami = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    key_name = aws_key_pair.flolki_key.key_name

    tags = {
        Name = "Gibs"
    }

    vpc_security_group_ids = var.SecurityGroup

    provisioner "file" {
        source = "${path.module}/installNginx.sh"
        destination = "/tmp/installNginx.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/installNginx.sh",
            "sudo sed -i -c 's/\\r//' /tmp/installNginx.sh",
            "/tmp/installNginx.sh"
        ]
    }

    connection {
        host = coalesce(self.public_ip, self.private_ip)
        type = "ssh"
        user = var.INSTANCE_USERNAME
        private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
}