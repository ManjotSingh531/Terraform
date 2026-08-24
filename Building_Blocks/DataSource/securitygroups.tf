data "aws_ip_ranges" "selected_ip_ranges" {
    regions = ["ap-northeast-1", "ap-southeast-1"]
    services = ["EC2"]
}

resource "aws_security_group" "web" {
    name = "terraform-web-sg"
    description = "Custom security group for web traffic"

    ingress {
        description = "Allow HTTP traffic from selected IP ranges"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow HTTPS traffic from selected IP ranges"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "Allow SSH traffic from selected IP ranges"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["13.201.77.92/32"]
    }

    tags = {
        createDate = data.aws_ip_ranges.selected_ip_ranges.create_date
        syncToken = data.aws_ip_ranges.selected_ip_ranges.sync_token
    }
}