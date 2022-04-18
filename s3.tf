resource "aws_s3_bucket" "temo" {
  bucket = "temodev"
}

resource "aws_s3_bucket_acl" "temo" {
  bucket = aws_s3_bucket.temo.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "temodev" {
  bucket = aws_s3_bucket.temo.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }
  routing_rule {
    condition {
      key_prefix_equals = "/"
    }
    redirect {
      replace_key_with = "index.html"
    }
  }
}

resource "aws_s3_bucket_policy" "temodev_s3_read" {
  bucket = aws_s3_bucket.temo.bucket
  policy = data.aws_iam_policy_document.temodev_s3_read_policy_document.json
}

data "aws_iam_policy_document" "temodev_s3_read_policy_document" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.temo.arn}/*",
    ]
  }
}

output "s3_bucket" {
  value = aws_s3_bucket.temo.arn
}

output "s3_bucket_url" {
  value = format("https://%s", aws_s3_bucket.temo.bucket_regional_domain_name)
}
output "s3_bucket_website_url" {
  value = format("http://%s", aws_s3_bucket_website_configuration.temodev.website_endpoint)
}
