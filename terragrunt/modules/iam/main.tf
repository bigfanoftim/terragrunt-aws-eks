resource "aws_iam_user" "this" {
  name = var.iam_user.name
}

resource "aws_iam_policy" "this" {
  name        = var.iam_policy.name
  description = var.iam_policy.description
  policy      = var.iam_policy.policy
}

resource "aws_iam_user_policy_attachment" "main" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}
