variable "AWS_ACCESS_KEY" {
    type = string
    default = "AKIAQSWPC2NSL7Q5N7OA"
}

variable "AWS_REGION" {
    type = string
    default = "ap-south-1"
}

variable "vpcname" {
    type = string
    default = "gibs-vpc"
}

variable "cidr" {
    type = string
    default = "0.0.0.0/0"
}

variable "instance_tenancy" {
    type = string
    default = "default"
}

variable "AMI" {
    type = map(string)
    default = {
        "ap-south-1" = "ami-01a00762f46d584a1"
    }
}

variable "enable_dns_hostnames" {
    type = bool
    default = false
}

variable "enable_dns_support" {
    type = bool
    default = true
}

variable "enable_classiclink" {
    type = bool
    default = null
}

variable "enable_classiclink_dns_support" {
    type = bool
    default = null
}

variable "enable_ipv6" {
    type = bool
    default = false
}

variable "vpc_environment" {
    type = string
    default = "dev"
}