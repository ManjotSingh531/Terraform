variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "security_group_ids" {
    type = list(string)
    default = ["sg-0b2f243cf09cc5d2f"]
}

variable "name" {
    type = string
}