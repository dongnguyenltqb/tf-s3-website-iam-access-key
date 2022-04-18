resource "aws_iam_user" "temo" {
  name = "temo"
}

resource "aws_iam_access_key" "iam_temo_access_key" {
  user = aws_iam_user.temo.name
}

output "iam_user_temo" {
  value = aws_iam_user.temo.name
}


output "iam_user_temo_access_key" {
  value = aws_iam_access_key.iam_temo_access_key.id
}

output "iam_user_temo_secret_key" {
  sensitive = true
  value     = aws_iam_access_key.iam_temo_access_key.secret
}
