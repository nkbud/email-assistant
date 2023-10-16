
## ---------------------------------------------------------------------------------------------------------------------
## Verified Domain Identity
## A verified identity is a domain, subdomain, or email address you use to send email through Amazon SES.
## Identity verification at the domain level extends to all email addresses under one verified domain identity.
## ---------------------------------------------------------------------------------------------------------------------

resource "aws_ses_domain_identity" "verified" {
  domain = var.domain_name
}

## ---------------------------------------------------------------------------------------------------------------------
## DomainKeys Identified Mail (DKIM) is an email authentication method that Amazon SES uses to verify domain ownership
## and that receiving mail servers use to validate email authenticity.
## You must configure DKIM as part of the domain verification process, i.e. RSA_2048_BIT
## ---------------------------------------------------------------------------------------------------------------------

resource "aws_ses_domain_dkim" "auth" {
  domain = aws_ses_domain_identity.verified.domain
}

resource "aws_ses_domain_identity_verification" "auth" {
  domain = aws_ses_domain_identity.verified.id
  depends_on = [
    aws_route53_record.mx
  ]
}
