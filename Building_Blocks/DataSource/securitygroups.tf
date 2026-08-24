data "aws_ip_ranges" "selected_ip_ranges" {
    regions = ["ap-southeast-2","ap-south-1"]
    services = ["EC2"]
}

resource "aws_security_group" "web" {
    name = "terraform-web-sg"
    description = "Allow inbound traffic on port 443 from selected IP ranges"

    ingress {
        description = "Allow inbound traffic on port 443 from selected IP ranges"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = slice(data.aws_ip_ranges.selected_ip_ranges.cidr_blocks, 0, 50)
    }

    tags = {
        createDate = data.aws_ip_ranges.selected_ip_ranges.create_date
        syncToken = data.aws_ip_ranges.selected_ip_ranges.sync_token
    }
}