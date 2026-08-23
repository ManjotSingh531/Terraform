variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY"{}
variable "AWS_REGION" {
    default = "ap-south-1"
}

variable "SecurityGroup" {
    type = list(string)
    default = ["sg-03e6a051495baff2b", "sg-0b2f243cf09cc5d2f"]
}

variable "AMI" {
    default = {
        "ap-south-1" = "ami-01a00762f46d584a1"
        "us-east-1" = "ami-0b6d9d3d33ba97d99"
        "us-east-2" = "ami-0e5497a77ef21b5ac"
        "us-west-1" = "ami-0fb110df4c5094d21"
    }
}

variable "PATH_TO_PRIVATE_KEY" {
    default = "floki"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "floki.pub"
}

variable "INSTANCE_USERNAME" {
    default = "ubuntu"
}