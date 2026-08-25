variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQSWPC2NSL7Q5N7OA"
}
variable "AWS_SECRET_KEY"{}

variable "AWS_REGION" {
    default = "ap-south-1"
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
    default = "gibs-key"
}

variable "PATH_TO_PUBLIC_KEY" {
    default = "gibs-key.pub"
}
