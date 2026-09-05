#Provider
provider "aws" {
    region = var.region
}

#Module
module "myvpc" {
    source = "./module/network"
}

#Key Pair
resource "aws_key_pair" "gibs-key" {
    key_name = "gibs-key"
    public_key = file(var.public_key_path)
}

#Instance
resource "aws_instance" "gibs_instance" {
    ami = var.instance_ami
    instance_type = var.instance_type
    subnet_id = module.network.public_subnet_id
    vpc_security_group_ids = ["${module.network.security_group_id}"]
    key_name = aws_key_pair.gibs-key.key_name

    tags = {
        Name = "gibs_instance"
        Environment = var.environment_tag
    }
}