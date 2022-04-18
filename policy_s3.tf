data "aws_iam_policy_document" "temoS3BucketTemoPolicyDocument" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]

    resources = [
      aws_s3_bucket.temo.arn,
      format("%s/*", aws_s3_bucket.temo.arn)
    ]
  }
}

resource "aws_iam_policy" "s3BucketTemoFullPolicy" {
  name        = "s3BucketRemoFullPolicy"
  description = "allow iam account interact with bucket on s3"
  policy      = data.aws_iam_policy_document.temoS3BucketTemoPolicyDocument.json
}

resource "aws_iam_policy_attachment" "temoS3BucketTemoAttach" {
  name       = "temoS3BucketTemoAttach"
  users      = [aws_iam_user.temo.name]
  policy_arn = aws_iam_policy.s3BucketTemoFullPolicy.arn
}

output "temo-s3-policy-arn" {
  value = aws_iam_policy.s3BucketTemoFullPolicy.arn
}
