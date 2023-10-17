
##
#
##

resource "aws_s3_bucket_notification" "lambda" {
  bucket = aws_s3_bucket.test.id
  lambda_function {
    lambda_function_arn = aws_lambda_function.invites.arn
    events              = ["s3:ObjectCreated:*"]
  }
  depends_on = [aws_lambda_permission.lambda]
}
