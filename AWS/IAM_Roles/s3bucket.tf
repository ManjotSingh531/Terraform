resource "aws_s3_bucket" "gibs-bucket" {
    bucket = "gibs-bucket"

    tags = {
      Name = "gibs-bucket"
    }
}