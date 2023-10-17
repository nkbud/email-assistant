
##
# Create IAM role and allow lambda.amazonaws.com to assume it
##

resource "aws_iam_role" "lambda" {
  name               = var.name
  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Effect": "Allow"
      }
    ]
  }
  EOF
  tags = var.tags
}

##
# Lambda's IAM policy
##

resource "aws_iam_policy" "lambda" {
  name        = var.name
  description = "Allow put logs, use s3 to store email and sent emails with SES"
  policy      = data.aws_iam_policy_document.lambda.json
}
resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}
data "aws_iam_policy_document" "lambda" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = ["${aws_s3_bucket.test.arn}/*"]
  }
}

## ---------------------------------------------------------------------------------------------------------------------
## SPECIAL PERMISSION?
## ---------------------------------------------------------------------------------------------------------------------

resource "aws_lambda_permission" "lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invites.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.test.arn
}
