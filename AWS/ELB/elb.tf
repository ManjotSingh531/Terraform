#AWS ELB Configuration
resource "aws_elb" "gibs-elb" {
    name = "gibs-elb"
    subnets = [aws_subnet.gibs_public_subnet_1.id, aws_subnet.gibs_public_subnet_2.id]
    security_groups = [aws_security_group.gibs-elb-sg.id]
    listener {
        instance_port = 80
        instance_protocol = "HTTP"
        lb_port = 80
        lb_protocol = "HTTP"
    }

    health_check {
        target = "HTTP:80/"
        interval = 30
        timeout = 3
        healthy_threshold = 2
        unhealthy_threshold = 2
    }

    cross_zone_load_balancing = true
    connection_draining = true
    connection_draining_timeout = 400

    tags = {
        Name = "gibs-elb"
    }
}

#Security Group for ELB
resource "aws_security_group" "gibs-elb-sg" {
    name = "gibs-elb-sg"
    description = "Security group for ELB"
    vpc_id = aws_vpc.gibs-vpc.id

    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "gibs-elb-sg"
    }
}

#Security Group for EC2 Instances
resource "aws_security_group" "gibs-ec2-sg" {
    name = "gibs-ec2-sg"
    description = "Security group for EC2 instances"
    vpc_id = aws_vpc.gibs-vpc.id

    egress = {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [aws_security_group.gibs-elb-sg.id]
    }

    tags = {
        Name = "gibs-ec2-sg"
    }
}