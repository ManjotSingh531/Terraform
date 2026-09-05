variable "region" {
    default = "us-east-1"
}

variable "instance_ami" {
    description = "AMI ID for the EC2 instance"
    default     = "ami-0b6d9d3d33ba97d99" # Example AMI ID, replace with a valid one
}

variable "instance_type" {
    description = "Instance type for the EC2 instance"
    default     = "t3.micro"
}

variable "public_key_path" {
    description = "Path to the public key file"
    default     = "~/.ssh/gibs-key.pub"
}

variable "environment_tag" {
    description = "Tag for the environment"
    default     = "dev"
}