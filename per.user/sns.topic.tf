
##
# SNS Topic notifications passed to Lambda
##

resource "aws_sns_topic" "incoming" {
  name = local.email_address
}

resource "aws_sns_topic_subscription" "sns-topic" {
  topic_arn = aws_sns_topic.incoming.arn
  endpoint  = aws_lambda_function.handler.arn
  protocol  = "lambda"
}


