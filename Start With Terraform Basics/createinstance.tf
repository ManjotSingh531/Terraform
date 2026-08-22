provider "aws" {
    region = "ap-south-1"
    access_key = "access_key"
    secret_key = "access_secret" 
}

resource "aws_instance" "myfirstinstance" {
    ami = "ami-07885360fed35f704"
    instance_type = "t3.micro"
}