
#
## 1 RULE SET FOR ALL RULES
#

resource "aws_ses_receipt_rule_set" "email" {
  rule_set_name = local.domain
}
resource "aws_ses_active_receipt_rule_set" "email" {
  rule_set_name = aws_ses_receipt_rule_set.email.rule_set_name
}
