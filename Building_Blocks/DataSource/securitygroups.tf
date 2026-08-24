data "aws_ip_ranges" "us_east_ip_ranges" {
    regions = ["ap-northeast-1", "ap-southeast-1"]
    services = ["EC2"]
}

resource "aws_security_group" "custom_us_east" {
    name = "custom_us_east"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = data.aws_ip_ranges.us_east_ip_ranges.cidr_blocks
    }

    tags = {
        createDate = data.aws_ip_ranges.us_east_ip_ranges.create_date
        syncToken = data.aws_ip_ranges.us_east_ip_ranges.sync_token
    }
}