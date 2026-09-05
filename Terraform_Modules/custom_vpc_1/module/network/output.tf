output "vpc_id" {
    value = aws_vpc.gibs_vpc.id
}

output "subnet_id" {
    value = aws_subnet.gibs_subnet.id
}

output "sg_id" {
    value = aws_security_group.gibs_security_group.id
}