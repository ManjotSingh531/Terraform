resource "aws_s3_bucket" "gibs-bucket" {
    bucket = "gibs-bucket"
    acl = "private"

    tags = {
      Name = "gibs-bucket"
    }
}