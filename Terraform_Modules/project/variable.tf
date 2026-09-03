variable "ami" {
    type = string
    description = "AMI ID for EC2 Instance"
}

variable "instance_type" {
    type = string
    description = "Instance type for EC2 Instance"
    default = "t3.micro"
}

variable "security_group_ids" {
    type = list(string)
    description = "List of security group IDs for EC2 Instance"
}

variable "name" {
    type = string
    description = "Name tag for EC2 Instance"
}