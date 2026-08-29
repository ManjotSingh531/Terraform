#Roles to Acces S3 Bucket
resource "aws_iam_role" "s3-gibsbucket-role" {
    name = "s3-gibsbucket-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

#Policy attach to Role
resource "aws_iam_role_policy" "s3-gibsbucket-role-policy" {
    name = "s3-gibsbucket-role-policy"
    role = aws_iam_role.s3-gibsbucket-role.id
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "arn:aws:s3:::gibs-bucket",
                "arn:aws:s3:::gibs-bucket/*"
            ]
        }
    ]
}
EOF
}

#Instance Identifier
resource "aws_iam_instance_profile" "s3-gibsbucket-instanceprofile" {
    name = "s3-gibsbucket-instanceprofile"
    role = aws_iam_role.s3-gibsbucket-role.name
}