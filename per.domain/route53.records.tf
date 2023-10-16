
## ---------------------------------------------------------------------------------------------------------------------
## Add MX record to our DNS domain.
## Permits AWS's inbound-smtp servers to receive our emails.
## ---------------------------------------------------------------------------------------------------------------------

resource "aws_route53_record" "mx" {
  name    = var.domain_name
  type    = "MX"
  zone_id = data.aws_route53_zone.domain.id
  ttl     = 600
  records = [
    "10 inbound-smtp.${var.aws_region}.amazonaws.com"
  ]
}

## ---------------------------------------------------------------------------------------------------------------------
## Add DKIM records to our DNS domain.
## Verifies that we're the owner?
## ---------------------------------------------------------------------------------------------------------------------

resource "aws_route53_record" "txt_dkim_token" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "_amazonses.${aws_ses_domain_identity.verified.id}"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.verified.verification_token]
}

resource "aws_route53_record" "cname_dkim_tokens" {
  count   = 3
  zone_id = data.aws_route53_zone.domain.id
  name    = "${aws_ses_domain_dkim.auth.dkim_tokens[count.index]}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${aws_ses_domain_dkim.auth.dkim_tokens[count.index]}.dkim.amazonses.com"]
}
