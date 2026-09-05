variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}

variable "availability_zone" {
    description = "Availability zone for the subnet"
    default     = "us-east-1a"
}

variable "public_key_path" {
    description = "Public Key Path"
    default = "~/.ssh/gibs-key.pub"
}

variable "environment_tag" {
    description = "Environment Tag"
    default = "dev"
}