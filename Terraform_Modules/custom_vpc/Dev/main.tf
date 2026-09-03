module "dev-vpc" {
    source = "../../custom_vpc"
    
    vpcname = "gibs01-vpc"
    cidr = "10.0.2.0/24"
    enable_dns_support = true
    enable_ipv6 = true
    vpc_environment = "dev"
}