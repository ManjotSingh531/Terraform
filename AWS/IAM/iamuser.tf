# IAM User
resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

# Group
resource "aws_iam_group" "admingroup" {
  name = "admingroup"
}

# Group Assign
resource "aws_iam_user_group_membership" "admin1_group_membership" {
  user   = [
    aws_iam_user.admin1.name,
    aws_iam_user.admin2.name
  ]
  groups = [aws_iam_group.admingroup.name]
}

# Policy Attachment for AWS Groups
resource "aws_iam_group_policy_attachment" "admin-user-access" {
    group      = aws_iam_group.admingroup.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}