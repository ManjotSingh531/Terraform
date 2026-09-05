output "vpc_id" {
    value = aws_vpc.gibs_vpc.id
}

output "public_subnet_id" {
    value = aws_subnet.gibs_subnet.id
}

output "security_group_id" {
    value = aws_security_group.gibs_security_group.id
    
}