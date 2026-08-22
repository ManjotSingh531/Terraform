resource "aws_instance" "myfirstinstance" {
    ami = "ami-07885360fed35f704"
    instance_type = "t3.micro"
}