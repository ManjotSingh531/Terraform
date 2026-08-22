resource "aws_instance" "myfirstinstance" {
    count = 3
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"

    tags = {
        Name = "myfirstinstance"
    }
}