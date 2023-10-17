

resource "aws_sns_topic" "test" {
  name = "${var.username}@oioio.email"
}
resource "aws_sns_topic_subscription" "sns-topic" {
  topic_arn = aws_sns_topic.test.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.test.arn
}
