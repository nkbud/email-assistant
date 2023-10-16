
##
# Rule set
##

resource "aws_ses_receipt_rule_set" "email" {
  rule_set_name = var.domain_name
}

resource "aws_ses_active_receipt_rule_set" "email" {
  rule_set_name = aws_ses_receipt_rule_set.email.rule_set_name
}

##
# Each rule
##

resource "aws_ses_receipt_rule" "actions" {
  name          = local.email_address
  rule_set_name = aws_ses_receipt_rule_set.email.id
  enabled       = true

  recipients = [
    local.email_address
  ]
  sns_action {
    position  = 1
    topic_arn = aws_sns_topic.incoming.arn
    encoding  = "UTF-8"
  }
  # SNS Max email size including headers: 150 KB
  # event["content"] is MIME format: https://tools.ietf.org/html/rfc2045

  depends_on = [
    aws_iam_policy.lambda
  ]
}
