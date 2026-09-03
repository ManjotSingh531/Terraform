#Auto Scaling Launch Configuration
resource "aws_launch_template" "gibs-launch-template" {
    name_prefix = "gibs-launch-template"
    image_id = lookup(var.AMI, var.AWS_REGION)
    instance_type = "t3.micro"
    key_name = aws_key_pair.gibs-key.key_name
    security_group_names = [aws_security_group.gibs-ec2-sg.name]
    user_data = file(nginx.sh)

    lifecycle {
        create_before_destroy = true
    }
}

#Generate Key
resource "aws_key_pair" "gibs-key" {
    key_name = "gibs-key"
    public_key = file(var.PATH_TO_PUBLIC_KEY)
}

#Auto Scaling Subnet
data "aws_subnets" "available" {
    filter {
        name = "availability-zone"
        values = ["ap-south-1b", "ap-south-1a"]
    }
}

#Auto Scaling Group
resource "aws_autoscaling_group" "gibs-autoscaling" {
    name = "gibs-autoscaling"
    vpc_zone_identifier = data.aws_subnets.available.ids
    launch_template {
        id = aws_launch_template.gibs-launch-template.id
        version = "$Latest"
    }
    min_size = 1
    max_size = 2
    health_check_grace_period = 200
    health_check_type = "EC2"
    force_delete = true

    tag {
        key = "Name"
        value = "gibs custom ec2 instance"
        propagate_at_launch = true
    }
}

output "ELB" {
    value = aws_elb.gibs-elb.dns_name
}