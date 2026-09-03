module "dev-qa-vpc" {
    source = "../../custom_vpc"
    
    vpcname = "gibs01-qa-vpc"
    cidr = "10.0.3.0/24"
    enable_dns_support = true
    enable_ipv6 = false
    vpc_environment = "dev-qa"
    AWS_REGION = "ap-south-1"
}