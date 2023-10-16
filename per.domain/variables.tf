
variable "domain_name" {

}

data "aws_route53_zone" "domain" {
  name = var.domain_name
}

variable "aws_region" {
  default = "us-east-1"
}