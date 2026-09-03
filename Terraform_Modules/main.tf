module "ec2_cluster" {
    source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance.git"

    name = "gibs-ec2-instance"
    ami = "ami-01a00762f46d584a1"
    instance_type = "t3.micro"
    subnet_id = "subnet-01b92eed43b828a5d"

    tags = {
        Terraform = "true"
        Environment = "dev"
    }
}