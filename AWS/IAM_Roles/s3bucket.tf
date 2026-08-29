resource "aws_s3_bucket" "gibs-bucket" {
    bucket = "gibs-bucket"
    tags = {
      Name = "gibs-bucket"
    }
}

resource "aws_s3_bucket_acl" "gibs-bucket_acl" {
    bucket = aws_s3_bucket.gibs-bucket.id
    acl    = "private"
}