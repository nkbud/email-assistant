

resource "aws_s3_bucket_policy" "s3" {
  bucket = aws_s3_bucket.test.id
  policy = data.aws_iam_policy_document.invites.json
}

data "aws_iam_policy_document" "invites" {
  statement {
    sid = "GiveSESPermissionToWriteEmail"

    principals {
      identifiers = ["ses.amazonaws.com"]
      type        = "Service"
    }
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.test.arn}/*"]

    condition {
      test     = "StringEquals"
      values   = [data.aws_caller_identity.current.account_id]
      variable = "aws:Referer"
    }
  }
}

