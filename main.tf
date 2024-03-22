resource "aws_iam_user" "user" {
  count = 3
  name = "user.${count.index + 1}"
}

resource "aws_iam_group" "Group" {
    name = "terraform-group"
}

resource "aws_iam_group_membership" "membership" {
  count = 3
  name  = "membership_${count.index + 1}"
  users = [aws_iam_user.user[count.index].name]
  group = aws_iam_group.Group.name
}

resource "aws_iam_policy" "policy" {
  name        ="policy-terraform"
  description = "policy_for_user"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
        ]
        Resource = [
          "arn:aws:s3:::*/*",
        ]
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "attachment" {
  group      = aws_iam_group.Group.name
  policy_arn = aws_iam_policy.policy.arn
}