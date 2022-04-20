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
variable "s3_read_account_arn" {
  type = string
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


resource "aws_iam_role" "s3_temo_read" {
  name = "s3_temo_read_only_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = var.s3_read_account_arn
        }
        Condition = {}
      },
    ]
  })
}

resource "aws_iam_role_policy" "s3_temo_read_polily" {
  name = "s3_temo_read_only_polily"
  role = aws_iam_role.s3_temo_read.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:listObject",
          "s3:getObject",
          "s3:putObject"
        ]
        Effect   = "Allow"
        Resource = [aws_s3_bucket.temo.arn, format("%s/*", aws_s3_bucket.temo.arn)]
      },
    ]
  })
}

output "temo-s3-policy-arn" {
  value = aws_iam_policy.s3BucketTemoFullPolicy.arn
}

output "temodev_s3_read_role_arn" {
  value = aws_iam_role.s3_temo_read.arn
}
